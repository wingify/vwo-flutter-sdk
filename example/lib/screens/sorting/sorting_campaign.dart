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
import 'package:vwo_flutter_example/providers/sorting_provider.dart';
import 'package:vwo_flutter_example/utils/color_constant.dart';
import 'package:vwo_flutter_example/utils/string_constant.dart';
import 'package:vwo_flutter_example/widgets/app_drawer.dart';
import 'package:vwo_flutter_example/screens/sorting/phone_card.dart';
import 'package:vwo_flutter_example/screens/sorting/phone_detail.dart';

class SortingCampaign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SortingProvider>(
      create: (context) => SortingProvider(),
      builder: (context, child) {
        return Consumer<SortingProvider>(
          builder: (context, sortingProvider, child) {
            return FutureBuilder(
              future: sortingProvider.getSortedList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                    body: sortingProvider.isDetailView
                        ? PhoneDetail()
                        : Container(
                            padding: EdgeInsets.all(5.0),
                            color: Colors.grey.withOpacity(0.3),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return PhoneCard(
                                  index: index,
                                );
                              },
                              itemCount: sortingProvider.mobileList.length,
                            ),
                          ),
                    appBar: AppBar(
                      title: Text(
                        StringConstant.SORTING_TITLE,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      centerTitle: true,
                      backgroundColor: ColorConstant.APP_BAR_BACKGROUND_COLOR,
                      actions: [
                        IconButton(
                            onPressed: () {
                              sortingProvider.update();
                            },
                            iconSize: 25,
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    drawer: AppDrawer(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
