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
import 'package:vwo_flutter/vwo_flutter.dart';
import 'package:vwo_flutter_example/model/house_data.dart';
import 'package:vwo_flutter_example/utils/constant.dart';

class HousingProvider extends ChangeNotifier {
  List<HouseData> oneBhkHouses = [];
  List<HouseData> twoBhkHouses = [];
  List<HouseData> threeBhkHouses = [];
  bool showDialog = false;
  String headingText = 'Use our House Agent!';
  String contentText =
      'You can use our in-house agents who can help you find a suitable house.';

  HousingProvider() {
    oneBhkHouses.add(
        HouseData(1, "Sai Enclave", 2000, 1, "assets/house_images/h1.jpeg"));
    oneBhkHouses.add(HouseData(
        2, "Zero One", 7000, 1, "assets/house_images/h2.jpg",
        type: Type.COMMERCIAL));
    oneBhkHouses.add(HouseData(
        3, "Siddhartha Enclave", 3000, 1, "assets/house_images/h3.jpg"));
    oneBhkHouses
        .add(HouseData(4, "Waterfront", 4000, 1, "assets/house_images/h4.jpg"));

    twoBhkHouses
        .add(HouseData(1, "Panchsheel", 3000, 2, "assets/house_images/h5.jpg"));
    twoBhkHouses
        .add(HouseData(2, "Marvel", 4000, 2, "assets/house_images/h6.jpg"));
    twoBhkHouses.add(HouseData(
        3, "Aurum", 5000, 2, "assets/house_images/h7.jpg",
        type: Type.COMMERCIAL));
    twoBhkHouses
        .add(HouseData(4, "Blue Bells", 700, 2, "assets/house_images/h8.jpg"));

    threeBhkHouses.add(
        HouseData(1, "Trump Towers", 5000, 3, "assets/house_images/h9.jpg"));
    threeBhkHouses
        .add(HouseData(2, "ABIL", 7000, 3, "assets/house_images/h10.jpg"));
    threeBhkHouses.add(
        HouseData(3, "Radhe Shaam", 4500, 3, "assets/house_images/h11.jpg"));
    threeBhkHouses.add(HouseData(
        4, "DSK", 3400, 3, "assets/house_images/h12.jpg",
        type: Type.COMMERCIAL));
  }

  void showHouseDetails(List<HouseData> houseData, int index) {
    showDialog = true;
    notifyListeners();
  }

  void trackConversion(String goal_upgrade_clicked) {
    VWO.trackConversion(Constants.GOAL_UPGRADE_CLICKED);
  }

  Future<String> getHeadingText() async {
    String text =
        await VWO.getStringForKey(Constants.KEY_DIALOG_HEADING, headingText);
    headingText = text;
    return text;
  }

  Future<String> getContentText() async {
    String text =
        await VWO.getStringForKey(Constants.KEY_DIALOG_CONTENT, contentText);
    contentText = text;
    return text;
  }
}
