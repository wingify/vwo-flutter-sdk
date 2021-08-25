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
import 'package:vwo_flutter_example/utils/string_constant.dart';

class APIKeyDialog extends StatefulWidget {
  @override
  _APIKeyDialogState createState() => _APIKeyDialogState();
}

class _APIKeyDialogState extends State<APIKeyDialog> {
  final TextEditingController apiKeyController = TextEditingController();

  final FocusNode focusNode = FocusNode();
  bool _validate = false;


  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationProvider provider =
    Provider.of<NavigationProvider>(context);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstant.LAUNCH_VWO,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              controller: apiKeyController,
              // focusNode: focusNode,
              autofocus: true,
              // scrollPadding: EdgeInsets.only(bottom: 50),
              textInputAction: TextInputAction.done,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: 18),
              maxLength: 39,
              decoration: InputDecoration(
                labelText: StringConstant.ENTER_API_KEY,
                errorText: _validate ? StringConstant.INVALID_API_KEY : null,
                // isDense: true,
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              ),
              autocorrect: false,
              maxLines: 1,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      if (apiKeyController.text.isEmpty || apiKeyController.text.length < 39) {
                        setState(() {
                          _validate = true;
                        });
                      } else {
                        String? response =
                        await provider.launchVWO(apiKeyController.text);
                        if (response == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Error while launching VWO")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("VWO is successfully launched")));
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          StringConstant.LAUNCH_VWO,
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}