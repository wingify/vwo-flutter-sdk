///
/// Copyright 2021 Wingify Software Pvt. Ltd.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vwo_flutter/vwo_config.dart';

enum VWOLog { OFF, SEVERE, WARNING, CONFIG, INFO, ALL }

class VWO {
  static const MethodChannel _channel = const MethodChannel('vwo_flutter_sdk');
  static String? _vwoLog;
  static StreamController<Map<String, dynamic>> _vwoStreamController =
      StreamController<Map<String, dynamic>>();
  static Stream vwoStream = _vwoStreamController.stream;

  /// Set the log level for the VWO.
  ///
  /// The [vwoLog] will be used to define the log level for the VWO.
  static void setLogLevel(VWOLog vwoLog) {
    switch (vwoLog) {
      case VWOLog.OFF:
        _vwoLog = 'off';
        break;
      case VWOLog.SEVERE:
        _vwoLog = 'severe';
        break;
      case VWOLog.WARNING:
        _vwoLog = 'warning';
        break;
      case VWOLog.CONFIG:
        _vwoLog = 'config';
        break;
      case VWOLog.INFO:
        _vwoLog = 'info';
        break;
      case VWOLog.ALL:
        _vwoLog = 'all';
        break;
      default:
        _vwoLog = 'off';
    }
  }

  /// Launch VWO SDK.
  /// Other APIs should only be used once the VWO SDK is launched.
  ///
  /// The [apiKey] is the apiKey for the account. This can be retrieved from the VWO dashboard.
  /// The [vwoConfig] is the different configs which could be set at the time of VWO initialization.
  /// Refer to developer docs for more info on [vwoConfig].
  static Future<String?> launch(String apiKey, {VWOConfig? vwoConfig}) async {
    try {
      if (apiKey.isEmpty) {
        print("apiKey is required to launch VWO.");
        return "error";
      }

      Map<String, dynamic> launchData = {
        "launchAsync": true,
        "apiKey": apiKey,
        "config": vwoConfig != null ? vwoConfig.toMap() : null,
      };

      if (_vwoLog != null) {
        launchData['vwoLog'] = _vwoLog;
      }

      _channel.setMethodCallHandler(vwoFlutterMethodCallHandler);
      final String vwoLaunch =
          await _channel.invokeMethod('launch', launchData);
      return vwoLaunch;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Returns the variation assigned to the user for the [testKey] passed.
  static Future<String?> getVariationNameForTestKey(String testKey) async {
    try {
      final String? variationName =
          await _channel.invokeMethod('variationNameForTestKey', {
        "testKey": testKey,
      });
      return variationName;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Returns the integer value for the [variableKey].
  ///
  /// [defaultValue] is the the value returned in case user has not become a part of campaign/variation.
  static Future<int?> getIntegerForKey(
      String variableKey, int defaultValue) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{
        "variableKey": variableKey,
        "defaultValue": defaultValue
      };

      final int integerValue =
          await _channel.invokeMethod('integerForKey', arguments);
      return integerValue;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Returns the String value for the [variableKey].
  ///
  /// [defaultValue] is the the value returned in case user has not become a part of campaign/variation.
  static Future<String?> getStringForKey(
      String variableKey, String defaultValue) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{
        "variableKey": variableKey,
        "defaultValue": defaultValue
      };

      final String stringValue =
          await _channel.invokeMethod('stringForKey', arguments);
      return stringValue;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Returns the Boolean value for the [variableKey].
  ///
  /// [defaultValue] is the the value returned in case user has not become a part of campaign/variation.
  static Future<bool?> getBooleanForKey(
      String variableKey, bool defaultValue) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{
        "variableKey": variableKey,
        "defaultValue": defaultValue
      };

      final bool boolValue =
          await _channel.invokeMethod('booleanForKey', arguments);
      return boolValue;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Returns the double value for the [variableKey].
  ///
  /// [defaultValue] is the the value returned in case user has not become a part of campaign/variation.
  static Future<double?> getDoubleForKey(
      String variableKey, double defaultValue) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{
        "variableKey": variableKey,
        "defaultValue": defaultValue
      };

      final double doubleValue =
          await _channel.invokeMethod('doubleForKey', arguments);
      return doubleValue;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Returns the integer/String/double/Boolean value for the [variableKey].
  ///
  /// [defaultValue] is the the value returned in case user has not become a part of campaign/variation.
  static Future<dynamic> getObjectForKey(
      String variableKey, dynamic defaultValue) async {
    try {
      if (defaultValue == null) {
        print("defaultValue cannot be null.");
        return null;
      }

      Map<String, dynamic> arguments = <String, dynamic>{
        "variableKey": variableKey,
        "defaultValue": defaultValue
      };

      final dynamic objectValue =
          await _channel.invokeMethod('objectForKey', arguments);
      return objectValue;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Tracks the conversion of the user for any particular campaign.
  ///
  /// [goalIdentifier] is the goal for which the user is to be tracked
  ///
  /// [revenueValue] should be passed if the goalType is revenue.
  /// refer developer docs for more info.
  static Future<void> trackConversion(String goalIdentifier,
      {double? revenueValue}) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{
        "goalIdentifier": goalIdentifier,
      };

      if (revenueValue != null) {
        arguments['revenueValue'] = revenueValue;
      }

      await _channel.invokeMethod('trackConversion', arguments);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Push the custom dimension to VWO servers.
  /// [customDimensionKey] is the key for custom dimension
  /// [customDimensionValue] is the value for custom dimension
  static Future<void> pushCustomDimension(
      String customDimensionKey, String customDimensionValue) async {
    try {
      if (customDimensionKey.isEmpty || customDimensionValue.isEmpty) {
        print("customDimensionKey or customDimensionValue cannot be empty.");
        return null;
      }

      Map<String, dynamic> arguments = <String, dynamic>{
        "customDimensionKey": customDimensionKey,
        "customDimensionValue": customDimensionValue
      };

      await _channel.invokeMethod('pushCustomDimension', arguments);
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Push the customVariable on VWO instance.
  /// [key] is the key for customVariable
  /// [value] is the value for customVariable
  static Future<void> setCustomVariable(
      String key, String value) async {
    try {
      if (key.isEmpty || value.isEmpty) {
        print("key or value cannot be empty.");
        return null;
      }

      Map<String, dynamic> arguments = <String, dynamic>{
        "key": key,
        "value": value
      };

      await _channel.invokeMethod('setCustomVariable', arguments);
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///Close the current VWO Stream
  static closeVWOStream() {
    if (!_vwoStreamController.isClosed) {
      _vwoStreamController.close();
    }
  }

  ///open a new VWO Stream
  static openVWOStream() {
    _vwoStreamController = StreamController<Map<String, dynamic>>();
    vwoStream = _vwoStreamController.stream;
  }

  ///Channel to listen events from android/iOS native
  static Future<dynamic> vwoFlutterMethodCallHandler(
      MethodCall methodCall) async {
    switch (methodCall.method) {
      case "vwo_integration":
        print(methodCall.arguments);
        if (_vwoStreamController.hasListener &&
            !_vwoStreamController.isClosed &&
            !_vwoStreamController.isPaused) {
          _vwoStreamController.add(Map.from(methodCall.arguments));
        } else {
          print("vwoStream has no listeners attached");
        }
        return "success";
      default:
        return "failure";
    }
  }
}
