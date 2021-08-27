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
import 'package:vwo_flutter_example/model/house_data.dart';
import 'package:vwo_flutter_example/providers/housing_provider.dart';
import 'package:vwo_flutter_example/screens/variable/housing_dialog.dart';
import 'package:vwo_flutter_example/utils/color_constant.dart';
import 'package:vwo_flutter_example/utils/string_constant.dart';
import 'package:provider/provider.dart';

class HousingCard extends StatelessWidget {
  final List<HouseData> houseData;
  final String bhk;

  HousingCard({required this.houseData, required this.bhk});

  @override
  Widget build(BuildContext context) {
    final HousingProvider provider = Provider.of<HousingProvider>(context);
    return Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: 270,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$bhk BHK Flats, Apartments near you',
                style: TextStyle(
                    color: ColorConstant.HOUSE_CATEGORY_COLOR, fontSize: 14),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 9,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: houseData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        String headingText = await provider.getHeadingText();
                        String contentText = await provider.getContentText();
                        showDialog(
                            context: context,
                            builder: (_) {
                              return HousingDialog(
                                heading: headingText,
                                content: contentText,
                              );
                            });
                      },
                      child: Card(
                        elevation: 2,
                        child: Stack(
                          children: [
                            Image.asset(houseData[index].image,
                                height: 250, fit: BoxFit.fitHeight, width: 190),
                            Positioned(
                                bottom: 1,
                                child: Container(
                                  height: 80,
                                  width: 190,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorConstant
                                            .HOUSE_GRADIENT_START_COLOR,
                                        ColorConstant.HOUSE_GRADIENT_MID_COLOR,
                                        ColorConstant.HOUSE_GRADIENT_END_COLOR
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                )),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    houseData[index].name,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    StringConstant.HOUSE_APARTMENT_INFO,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 5,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
