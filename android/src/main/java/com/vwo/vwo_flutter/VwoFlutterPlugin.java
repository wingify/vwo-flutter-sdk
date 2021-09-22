/**
 * Copyright 2021 Wingify Software Pvt. Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


package com.vwo.vwo_flutter;

import android.content.BroadcastReceiver;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;

import com.vwo.mobile.Initializer;
import com.vwo.mobile.VWO;
import com.vwo.mobile.VWOConfig;
import com.vwo.mobile.events.VWOStatusListener;
import com.vwo.mobile.utils.VWOLog;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;


/** VwoFlutterPlugin */
public class VwoFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  private static final String TAG = "vwo_flutter";
  private MethodChannel channel;
  Context context;

//  public static void registerWith(PluginRegistry.Registrar registrar) {
//    final MethodChannel channel = new MethodChannel(registrar.messenger(), "vwo_flutter_sdk");
//    channel.setMethodCallHandler(new VwoFlutterPlugin(registrar.activity(), registrar.context(), channel));
//  }
  
  
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
    Log.d(TAG, "onMethodCall: " + call.method);
    switch (call.method) {
      case "launch":
        try {
          Log.d(TAG, "inside launch: " + call.method);
          Log.d(TAG, "value of vwoLog" + call.argument("vwoLog"));
          if ((String) call.argument("vwoLog") != null) {
            switch ((String) call.argument("vwoLog")) {
              case "off":
                VWOLog.setLogLevel(VWOLog.OFF);
                break;
              case "severe":
                VWOLog.setLogLevel(VWOLog.SEVERE);
                break;
              case "warning":
                VWOLog.setLogLevel(VWOLog.WARNING);
                break;
              case "config":
                VWOLog.setLogLevel(VWOLog.CONFIG);
                break;
              case "info":
                VWOLog.setLogLevel(VWOLog.INFO);
                break;
              case "all":
                VWOLog.setLogLevel(VWOLog.ALL);
                break;
              default:
                VWOLog.setLogLevel(VWOLog.OFF);
            }
          }
          VWOConfig.Builder vwoConfigBuilder = new VWOConfig.Builder();
          VWOConfig vwoConfig = null;
          HashMap<String, Object> configData = (HashMap<String, Object>) call.argument("config");
          if (configData != null && !configData.isEmpty()) {
            if (configData.get("optOut") != null) {
              vwoConfigBuilder.setOptOut((boolean) configData.get("optOut"));
            }
            if (configData.get("userId") != null) {
              vwoConfigBuilder.userID((String) configData.get("userId"));
            }
            if (configData.get("disablePreview") != null) {
              vwoConfigBuilder.disablePreview();
            }
            if (configData.get("customVariables") != null) {
              vwoConfigBuilder.setCustomVariables((Map<String, String>) configData.get("customVariables"));
            }
            if (configData.get("customDimension") != null) {
              Map<String, String> customDimesionData = (Map<String, String>) configData
                      .get("customDimension");
              if (customDimesionData.get("customDimensionKey") != null && customDimesionData
                      .get("customDimensionValue") != null)
                vwoConfigBuilder.setCustomDimension((String) customDimesionData.get("customDimensionKey"), (String) customDimesionData
                        .get("customDimensionValue"));
            }
            vwoConfig = vwoConfigBuilder.build();
          }

          Initializer vwoInitializer = VWO.with(context, (String) call.argument("apiKey"));
          if (vwoConfig != null) {
            vwoInitializer.config(vwoConfig);
          }
          if ((boolean) call.hasArgument("launchAsync")) {
            vwoInitializer.launch(new VWOStatusListener() {
              @Override
              public void onVWOLoaded() {
                result.success("success");
              }

              @Override
              public void onVWOLoadFailure(String s) {
                result.error("1001", "error", s);
              }
            });
          } else if ((boolean) call.hasArgument("launchSync")) {
            if (call.hasArgument("launchTimeout")) {
              vwoInitializer.launchSynchronously((long) call.argument("launchTimeout"));
            } else {
              vwoInitializer.launchSynchronously(0);
            }
            result.success("success");

          }
        } catch (Exception e) {
          result.error("1002", "error", e);
        }
        break;
      case "setCustomVariable":
        VWO.setCustomVariable(call.<String>argument("key"), call.<String>argument("value"));
        result.success("success");
        break;
      case "variationNameForTestKey":
        String variationName = VWO.getVariationNameForTestKey((String) call.argument("testKey"));
        result.success(variationName);
        break;
      case "trackConversion":
        if (call.hasArgument("revenueValue")) {
          VWO.trackConversion((String) call.argument("goalIdentifier"), (double) call.argument("revenueValue"));
        } else {
          VWO.trackConversion((String) call.argument("goalIdentifier"));
        }
        result.success("success");
        break;
      case "integerForKey":
        int integerValue = VWO.getIntegerForKey((String) call.argument("variableKey"), (int) call.argument("defaultValue"));
        result.success(integerValue);
        break;
      case "stringForKey":
        String stringValue = VWO.getStringForKey((String) call.argument("variableKey"), (String) call.argument("defaultValue"));
        result.success(stringValue);
        break;

      case "doubleForKey":
        double doubleValue = VWO.getDoubleForKey((String) call.argument("variableKey"), (double) call.argument("defaultValue"));
        result.success(doubleValue);
        break;
      case "booleanForKey":
        boolean booleanValue = VWO.getBooleanForKey((String) call.argument("variableKey"), (boolean) call.argument("defaultValue"));
        result.success(booleanValue);
        break;
      case "objectForKey":
        Object objectValue = VWO.getObjectForKey((String) call.argument("variableKey"), (Object) call.argument("defaultValue"));
        result.success(objectValue);
        break;
      case "pushCustomDimension":
        VWO.pushCustomDimension((String) call.argument("customDimensionKey"), (String) call.argument("customDimensionValue"));
        result.success("success");
        break;
      default:
        result.notImplemented();
    }
  }

  private  BroadcastReceiver receiver = new BroadcastReceiver() {
    @Override
    public void onReceive(Context context, Intent intent) {
      Bundle extras = intent.getExtras();
      String campaignId = extras.getString(VWO.Constants.ARG_CAMPAIGN_ID);
      String campaignName = extras.getString(VWO.Constants.ARG_CAMPAIGN_NAME);
      String variationId = extras.getString(VWO.Constants.ARG_VARIATION_ID);
      String variationName = extras.getString(VWO.Constants.ARG_VARIATION_NAME);
      // Write your Analytics code here
      Map<String, String> map = new HashMap<String, String>();
      Set<String> ks = extras.keySet();
      Iterator<String> iterator = ks.iterator();
      while (iterator.hasNext()) {
        String key = iterator.next();
        map.put(key, extras.getString(key));
      }//w

      Log.d(TAG, String.format("User became part of Campaign %s with id %s " +
              "\nVariation %s with id %s", campaignName, campaignId, variationName, variationId));

      channel.invokeMethod("vwo_integration", map, new MethodChannel.Result() {
        @Override
        public void success(@Nullable Object result) {
          Log.d(TAG, result.toString());
        }

        @Override
        public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
          Log.d(TAG, errorMessage.toString());
        }

        @Override
        public void notImplemented() {
          Log.d(TAG, "vwo_integration_response method not implemented");
        }
      });
    }
  };

  ContextWrapper contextWrapper = new ContextWrapper(this.context);

  @Override
  public void onAttachedToEngine(
          @NonNull FlutterPluginBinding binding) {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "vwo_flutter_sdk");
    this.context = binding.getApplicationContext();
    this.channel.setMethodCallHandler(this);
    IntentFilter intentFilter = new IntentFilter(VWO.Constants.NOTIFY_USER_TRACKING_STARTED);
    LocalBroadcastManager.getInstance(context).registerReceiver(receiver, intentFilter);
  }

  @Override
  public void onDetachedFromEngine(
          @NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    LocalBroadcastManager.getInstance(context).unregisterReceiver(receiver);
    context = null;
  }
}
