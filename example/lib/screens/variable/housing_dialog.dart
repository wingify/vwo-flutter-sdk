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
import 'package:vwo_flutter_example/providers/housing_provider.dart';
import 'package:vwo_flutter_example/utils/color_constant.dart';
import 'package:vwo_flutter_example/utils/constant.dart';
import 'package:vwo_flutter_example/utils/string_constant.dart';

class HousingDialog extends StatelessWidget {
  String heading;
  String content;
  HousingDialog({required this.heading, required this.content});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HousingProvider>(
      create: (_) => HousingProvider(),
      child: Consumer<HousingProvider>(
        builder: (context, provider, child) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: Text(
                      heading,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: ColorConstant.HOUSE_SUBTITLE_COLOR,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      provider.trackConversion(Constants.GOAL_UPGRADE_CLICKED);
                      Navigator.of(context).pop();
                    },
                    color: ColorConstant.HOUSE_DIALOG_BUTTON_COLOR,
                    child: Container(
                      child: Text(
                        StringConstant.HOUSE_DIALOG_UPRAGE,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: ColorConstant.HOUSE_DIALOG_BUTTON_COLOR,
                    child: Container(
                      child: Text(
                        StringConstant.HOUSE_DIALOG_CANCEL,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
