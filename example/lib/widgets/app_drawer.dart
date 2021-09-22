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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vwo_flutter_example/providers/navigation_provider.dart';
import 'package:vwo_flutter_example/screens/sorting/sorting_campaign.dart';
import 'package:vwo_flutter_example/screens/variable/variable_campaign.dart';
import 'package:vwo_flutter_example/utils/string_constant.dart';
import 'package:vwo_flutter_example/widgets/apikey_dialog.dart';

class AppDrawer extends StatelessWidget {
  final TextEditingController apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NavigationProvider provider = Provider.of<NavigationProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              StringConstant.CHOOSE_CAMPAIGN,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          InkWell(
            onTap: () {
              provider.campaignSelected(0);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SortingCampaign()));
            },
            child: Container(
              color: provider.campaignTypeSelected == 0
                  ? Colors.grey
                  : Colors.white,
              padding: EdgeInsets.all(15.0),
              child: Text(
                provider.campaignlist[0],
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          // SizedBox(height: 5,),
          InkWell(
            onTap: () {
              provider.campaignSelected(1);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => VariableCampaign()));
            },
            child: Container(
              color: provider.campaignTypeSelected == 1
                  ? Colors.grey
                  : Colors.white,
              padding: EdgeInsets.all(15.0),
              child: Text(
                provider.campaignlist[1],
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              StringConstant.SETTINGS,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (_) {
                    return APIKeyDialog();
                  });
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                StringConstant.ENTER_API_KEY,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
