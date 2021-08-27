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
import 'package:vwo_flutter_example/utils/string_constant.dart';
import 'package:vwo_flutter_example/widgets/app_drawer.dart';
import 'package:vwo_flutter_example/screens/variable/housing_card.dart';

class VariableCampaign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HousingProvider>(
      create: (context) => HousingProvider(),
      builder: (context, child) {
        return Consumer<HousingProvider>(
          builder: (context, housingProvider, child) {
            return Scaffold(
              // backgroundColor: Colors.grey.withOpacity(0.5),
              appBar: AppBar(
                title: Text(
                  StringConstant.VARIABLE_TITLE,
                  style: TextStyle(fontSize: 16.0),
                ),
                centerTitle: true,
                backgroundColor: ColorConstant.APP_BAR_BACKGROUND_COLOR,
              ),
              drawer: AppDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    HousingCard(
                        houseData: housingProvider.oneBhkHouses, bhk: "1"),
                    SizedBox(
                      height: 10,
                    ),
                    HousingCard(
                        houseData: housingProvider.twoBhkHouses, bhk: "2"),
                    SizedBox(
                      height: 10,
                    ),
                    HousingCard(
                        houseData: housingProvider.threeBhkHouses, bhk: "3"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
