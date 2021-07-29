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
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vwo_flutter_example/providers/sorting_provider.dart';
import 'package:vwo_flutter_example/utils/color_constant.dart';
import 'package:vwo_flutter_example/utils/string_constant.dart';

class PhoneDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SortingProvider sortingProvider = Provider.of<SortingProvider>(context);
    //track-conversion
    sortingProvider.trackConversion(
        sortingProvider.mobileList[sortingProvider.selectedPhone].price);
    return WillPopScope(
      onWillPop: () async {
        sortingProvider.selectedPhone = 0;
        sortingProvider.showDetailView(false);
        return false;
      },
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    sortingProvider.selectedPhone = 0;
                    sortingProvider.showDetailView(false);
                  })),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  '${sortingProvider.mobileList[sortingProvider.selectedPhone].imagePath}',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${sortingProvider.mobileList[sortingProvider.selectedPhone].name}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '\$${sortingProvider.mobileList[sortingProvider.selectedPhone].price}',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
                SizedBox(
                  height: 20,
                ),
                SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: sortingProvider
                        .mobileList[sortingProvider.selectedPhone].rating,
                    size: 40.0,
                    isReadOnly: true,
                    color: ColorConstant.STAR_RATING_COLOR,
                    borderColor: Colors.grey,
                    spacing: 0.0),
                Divider(
                  thickness: 2,
                  color: Colors.black26,
                ),
                SizedBox(
                  height: 20,
                ),
                _productDetail(sortingProvider
                        .mobileList[sortingProvider.selectedPhone].inStock
                    ? StringConstant.IN_STOCK
                    : StringConstant.OUT_OF_STOCK),
                SizedBox(
                  height: 10,
                ),
                _productDetail(sortingProvider
                        .mobileList[sortingProvider.selectedPhone].codAvailable
                    ? StringConstant.COD_AVAILABLE
                    : StringConstant.COD_UNAVAILABLE),
                SizedBox(
                  height: 10,
                ),
                _productDetail(sortingProvider
                    .mobileList[sortingProvider.selectedPhone].variantDetails),
                SizedBox(
                  height: 30,
                ),
                _actionButton(StringConstant.BUY_NOW, ColorConstant.BUY_NOW_COLOR),
                SizedBox(
                  height: 10,
                ),
                _actionButton(StringConstant.ADD_TO_CART, ColorConstant.ADD_TO_CART_COLOR),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDetail(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
      child: Text(
        '\u2022 $text',
        style: TextStyle(fontSize: 11, color: Colors.black),
      ),
    );
  }

  Widget _actionButton(String text, Color color) {
    return Container(
        width: 250,
        height: 48,
        color: color,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ));
  }
}
