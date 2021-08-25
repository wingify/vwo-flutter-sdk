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
import 'package:vwo_flutter_example/model/mobile_data.dart';
import 'package:vwo_flutter_example/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vwo_flutter/vwo_flutter.dart';

class SortingProvider extends ChangeNotifier {
  List<MobileData> mobileList = [];
  int selectedPhone = 0;
  bool isDetailView = false;

  SortingProvider() {
    mobileList.add(MobileData(
        1,
        "iPhone 6 (16GB, Black)",
        399,
        "\$",
        true,
        true,
        "assets/phone_images/iphone.png",
        "Apple",
        "Also Available in Space Grey and Rose Gold",
        4));
    mobileList.add(MobileData(
        2,
        "Samsung Galaxy S8 (64GB, Midnight Black)",
        799,
        "\$",
        true,
        false,
        "assets/phone_images/s8.png",
        "Samsung",
        "Also available in Maple Gold and Orchid Grey",
        4));
    mobileList.add(MobileData(
        3,
        "Google Pixel (32GB, Very Silver)",
        699,
        "\$",
        false,
        false,
        "assets/phone_images/pixel.png",
        "Google",
        "Also Available in Quite black",
        5));
    mobileList.add(MobileData(4, "ZTE Max XL (16GB)", 695, "\$", true, false,
        "assets/phone_images/zte.png", "ZTE", "Available in 16GB", 3));
    mobileList.add(MobileData(
        5,
        "Galaxy J250(16GB)",
        400,
        "\$",
        true,
        false,
        "assets/phone_images/galaxy_j250.jpg",
        "Samsung",
        "Samsung Galaxy J250 16GB",
        4));
    mobileList.add(MobileData(
        6,
        "Honor 7X (Blue, 4GB RAM + 32GB Memory)",
        159,
        "\$",
        false,
        false,
        "assets/phone_images/honor_7x.jpg",
        "Huawei",
        "Honor 7X 4GB RAM and 32GB ROM",
        3));
    mobileList.add(MobileData(
        7,
        "Mi Max 2 (Black, 32GB)",
        169,
        "\$",
        true,
        false,
        "assets/phone_images/mi_mix_2.jpg",
        "Mi",
        "Mi Max 2 Black, 4GB RAM and 32GB ROM",
        4));
    mobileList.add(MobileData(
        8,
        "Redmi Y2 (Dark Grey, 32GB)",
        129,
        "\$",
        true,
        true,
        "assets/phone_images/redmi_y2.jpg",
        "Mi",
        "Redmi Y2 Dark Grey, 3GB RAM and 32GB ROM",
        5));
    mobileList.add(MobileData(
        9,
        "OnePlus 6 (Mirror Black 6GB RAM + 64GB Memory)",
        459,
        "\$",
        true,
        false,
        "assets/phone_images/one_plus_6.jpg",
        "OnePlus",
        "OnePlus 6 Mirror Black 6GB RAM and 64GB Memory",
        5));
  }

  void showDetailView(bool status) {
    isDetailView = status;
    notifyListeners();
  }

  void trackConversion(double price) {
    VWO.trackConversion(Constants.GOAL_PRODUCT_VIEWED);
    VWO.trackConversion(Constants.GOAL_PRODUCT_PURCHASED, revenueValue: price);
  }

  Future<bool> getSortedList() async {
    String? variationName =
      await VWO.getVariationNameForTestKey(Constants.TEST_KEY_SORTING);
    if (Constants.CUSTOM_DIMENSION_KEY.isNotEmpty && Constants.CUSTOM_DIMENSION_VALUE.isNotEmpty) {
      VWO.pushCustomDimension(Constants.CUSTOM_DIMENSION_KEY, Constants.CUSTOM_DIMENSION_VALUE);
    }
    if (variationName != null) {
      switch (variationName) {
        case Constants.TEST_KEY_VALUE_SORT_BY_NAME:
          sortByName();
          break;
        case Constants.TEST_KEY_VALUE_SORT_BY_PRICE:
          sortByPrice();
          break;
        default:
          sortById();
          break;
      }
      return true;
    } else {
      return sortById();
    }
  }

  sortByName() {
    mobileList.sort((a, b) => a.name.compareTo(b.name));
    return true;
  }

  sortById() {
    mobileList.sort((a, b) => a.id.compareTo(b.id));
    return true;
  }

  sortByPrice() {
    mobileList.sort((a, b) => a.price.compareTo(b.price));
    return true;
  }

  void update() {
    notifyListeners();
  }

  Future<String?> isAPIKeyExists() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiKey = prefs.getString(Constants.API_KEY);
    if (apiKey != null && apiKey.isNotEmpty) {
      return apiKey;
  }
    return null;
  }
}
