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


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vwo_flutter/vwo_flutter.dart';
import 'package:vwo_flutter/vwo_config.dart';
import 'package:vwo_flutter_example/utils/constant.dart';

class NavigationProvider extends ChangeNotifier {
  List<String> campaignlist = ['Sorting Campaign', 'VariableCampaign'];
  int campaignTypeSelected = 0;
  List<String> settings = ['Enter API Key'];

  void campaignSelected(int index) {
    campaignTypeSelected = index;
    notifyListeners();
  }

  Future<String?> launchVWO(String apiKey) async {
    VWO.setLogLevel(VWOLog.ALL);
    VWOConfig vwoConfig = VWOConfig();
    String? response = '';
    if (Platform.isIOS) {
      response = await VWO.launch(apiKey, vwoConfig: vwoConfig);
    } else {
      response = await VWO.launch(apiKey, vwoConfig: vwoConfig);
    }
    if (response == 'success') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.API_KEY, apiKey);
    }
    print('response of vwo launch is $response');
    return response;
  }
}
