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

class VWOConfig {
  bool? optOut;
  Map<String, dynamic>? customVariables;
  String? customDimensionKey;
  String? customDimensionValue;
  String? userId;
  bool? disablePreview;

  VWOConfig(
      {this.optOut,
      this.customVariables,
      this.userId,
      this.disablePreview,
      this.customDimensionKey,
      this.customDimensionValue});

  Map<String, dynamic> toMap() {
    return {
      "optOut": optOut,
      "userId": userId,
      "disablePreview": disablePreview,
      "customVariables": customVariables,
      "customDimension": {
        "customDimensionKey": customDimensionKey,
        "customDimensionValue": customDimensionValue
      }
    };
  }
}
