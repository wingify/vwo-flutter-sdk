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
import 'package:vwo_flutter/vwo_flutter.dart';
import 'package:vwo_flutter_example/providers/navigation_provider.dart';
import 'package:vwo_flutter_example/screens/sorting/sorting_campaign.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    VWO.vwoStream.listen((vwoProperties) {
      print("recieved data from vwo:- $vwoProperties");
      String campaignId = vwoProperties["vwo_campaign_name"];
      String campaignName =  vwoProperties["vwo_campaign_id"];
      String variationId =  vwoProperties["vwo_variation_name"];
      String variationName =  vwoProperties["vwo_variation_id"];
      print("Campaign id $campaignId, Campaign name $campaignName, VariationId $variationId, VariationName $variationName" );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider(),
        ),
      ],
      child: MaterialApp(
        home: SortingCampaign(),
      ),
    );
  }
}
