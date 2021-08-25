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
import 'package:vwo_flutter_example/providers/sorting_provider.dart';
import 'package:vwo_flutter_example/utils/color_constant.dart';

class PhoneCard extends StatelessWidget {
  final int index;

  PhoneCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final SortingProvider sortingProvider =
        Provider.of<SortingProvider>(context);
    return InkWell(
      onTap: () {
        sortingProvider.selectedPhone = index;
        sortingProvider.showDetailView(true);
      },
      child: Card(
        child: Container(
          height: 98,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  sortingProvider.mobileList[index].imagePath,
                  height: 75,
                ),
              ),
              Expanded(
                flex: 8,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(height: 15),
                      Text(
                        '${sortingProvider.mobileList[index].name}',
                        style:
                            TextStyle(fontSize: 14, color: ColorConstant.APP_BAR_BACKGROUND_COLOR),
                      ),
                      Text(
                        'by ${sortingProvider.mobileList[index].vendor}',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFF757575)),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                  subtitle: Container(
                    // margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('\$${sortingProvider.mobileList[index].price}',
                        style: TextStyle(fontSize: 15, color: Colors.red)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
