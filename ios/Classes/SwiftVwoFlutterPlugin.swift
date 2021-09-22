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

import Flutter
import UIKit
import VWO

public class SwiftVwoFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "vwo_flutter_sdk", binaryMessenger: registrar.messenger())
        let instance = SwiftVwoFlutterPlugin()
        
        self.addObserver(channel)
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    static func addObserver(_ channel: FlutterMethodChannel) {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.VWOUserStartedTrackingInCampaign,
            object: nil, queue: nil) {
            notification in
            print("received notification from flutter")
            if let campaign = notification.userInfo as? [String : String] {
                let campaignName = campaign["vwo_campaign_name"]!
                let campaignId = campaign["vwo_campaign_id"]!
                let variationName = campaign["vwo_variation_name"]!
                let variationId = campaign["vwo_variation_id"]!
                channel.invokeMethod("vwo_integration", arguments: notification.userInfo)
                print("Campaign \(campaignName) \(campaignId)")
                print("Variation \(variationName) \(variationId)")
            }
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError(
                code: "arguments",
                message: "Missing or invalid arguments",
                details: nil
            ))
            return
        }
        switch call.method {
        case "launch":
            do {
                if let vwoLog: String = try arguments.optionalArgument(for: "vwoLog") {
                    switch vwoLog {
                    case "off":
                        VWO.logLevel = .none
                    case "all":
                        VWO.logLevel = .debug
                    case "info":
                        VWO.logLevel = .info
                    case "warning":
                        VWO.logLevel = .warning
                    case "severe":
                        VWO.logLevel = .error
                    default:
                        VWO.logLevel = .none
                    }
                }
                var vwoConfig: VWOConfig?  = nil
                if let config: [String: Any] = try arguments.argument(for: "config")  {
                    vwoConfig = VWOConfig()
                    
                    if let optOut: Bool = config["optOut"] as? Bool {
                        vwoConfig?.optOut = optOut
                    }
                    if let userId: String = config["userId"] as? String  {
                        vwoConfig?.userID = userId
                    }
                    if let disablePreview: Bool = config["disablePreview"] as? Bool  {
                        vwoConfig?.disablePreview = disablePreview
                    }
                    if let customVariables: [String: String] = config["customVariables"] as? [String: String]  {
                        vwoConfig?.customVariables = customVariables
                    }
                    if let customDimension: [String: Any] = config["customDimension"] as? [String: Any], let customDimensionKey: String = customDimension["customDimensionKey"] as? String, let customDimensionValue: String = customDimension["customDimensionValue"] as? String {
                        vwoConfig?.setCustomDimension(customDimensionKey: customDimensionKey, customDimensionValue: customDimensionValue)
                    }
                }
                if let launchSync: Bool = try arguments.optionalArgument(for: "launchSync") {
                    if vwoConfig == nil {
                        result("config is required for launching VWO Syncronously")
                    } else {
                        VWO.launchSynchronously(apiKey: try arguments.argument(for: "apiKey"), timeout: try arguments.argument(for: "launchTimeout"), config: vwoConfig!)
                        result("launch success")
                    }
                } else {
                    VWO.launch(apiKey: try arguments.argument(for: "apiKey"), config: vwoConfig != nil ? vwoConfig! : nil, completion: {
                        result("launch success")
                    }, failure: { (errorString) in
                        print("response from launch is \(errorString)")
                        result(errorString)
                    })
                }
            } catch {
                result(error.localizedDescription)
            }
            
        case "variationNameForTestKey":
            do {
                let variation = VWO.variationNameFor(testKey: try arguments.argument(for: "testKey"))
                result(variation)
            } catch {
                result(error.localizedDescription)
            }
            
            
        case "trackConversion":
            do {
                if let revenueValue: Double = try arguments.optionalArgument(for: "revenueValue") {
                    VWO.trackConversion(try arguments.argument(for: "goalIdentifier"), value: revenueValue)
                } else {
                    VWO.trackConversion(try arguments.argument(for: "goalIdentifier"))
                }
                
                result("success")
            } catch {
                result(error.localizedDescription)
            }
        case "integerForKey":
            do {
                let intValue = VWO.intFor(key: try arguments.argument(for: "variableKey"), defaultValue: try arguments.argument(for: "defaultValue"))
                result(intValue)
            } catch {
                result(error.localizedDescription)
            }
        case "stringForKey":
            do {
                let stringValue = VWO.stringFor(key: try arguments.argument(for: "variableKey"), defaultValue: try arguments.argument(for: "defaultValue"))
                result(stringValue)
            } catch {
                result(error.localizedDescription)
            }
        case "doubleForKey":
            do {
                let doubleValue = VWO.doubleFor(key: try arguments.argument(for: "variableKey"), defaultValue: try arguments.argument(for: "defaultValue"))
                result(doubleValue)
            } catch {
                result(error.localizedDescription)
            }
        case "booleanForKey":
            do {
                let boolValue = VWO.boolFor(key: try arguments.argument(for: "variableKey"), defaultValue: try arguments.argument(for: "defaultValue"))
                result(boolValue)
            } catch {
                result(error.localizedDescription)
            }
        case "objectForKey":
            do {
                let objectValue = VWO.objectFor(key: try arguments.argument(for: "variableKey"), defaultValue: try arguments.argument(for: "defaultValue"))
                result(objectValue)
            } catch {
                result(error.localizedDescription)
            }
        case "pushCustomDimension":
            do {
                VWO.pushCustomDimension(customDimensionKey: try arguments.argument(for: "customDimensionKey"), customDimensionValue: try arguments.argument(for: "customDimensionValue"))
                result("success")
            } catch {
                result(error.localizedDescription)
            }
        case "setCustomVariable":
            do {
                VWO.setCustomVariable(key: try arguments.argument(for: "key"), value: try arguments.argument(for: "value"))
                result("success")
            } catch {
                result(error.localizedDescription)
            }
        default:
            result(nil)
        }
    }
}

fileprivate extension Dictionary where Key == String, Value == Any {
    func argument<T>(for key: String) throws -> T {
        if self[key] == nil {
            throw FlutterError.missingArgument(for: key)
        }
        if let argument = self[key] as? T {
            return argument
        } else {
            throw FlutterError.invalidType(for: key)
        }
    }
    
    func optionalArgument<T>(for key: String) throws -> T? {
        if self[key] == nil {
            return nil
        }
        if let argument = self[key] as? T {
            return argument
        } else {
            throw FlutterError.invalidType(for: key)
        }
    }
}

extension FlutterError: Error { }

fileprivate extension FlutterError {
    static func missingArgument(for key: String) -> FlutterError {
        return FlutterError(
            code: "argument",
            message: "Missing argument for key: \(key)",
            details: nil
        )
    }
    
    static func invalidType(for key: String) -> FlutterError {
        return FlutterError(
            code: "argument",
            message: "Invalid type for argument with key: \(key)",
            details: nil
        )
    }
}

