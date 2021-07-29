# VWO Flutter SDK
======================================

This open source library allows you to A/B Test your Flutter app.

## Requirements

* Flutter sdk version ```>=2.7.0 <3.0.0```

## Documentation

Refer [Official VWO Documentation](https://developers.vwo.com/reference#flutter-guide)

## Basic Usage

**Instantiation**

SDK provides a method to instantiate a VWO client as an instance. The method accepts an apiKey and an object to configure the VWO client.
The required parameter for instantiating the SDK is apiKey.

```dart
VWOConfig vwoConfig = VWOConfig();
if (Platform.isIOS) {
  await VWO.launch(ios_apiKey, vwoConfig: vwoConfig);
} else {
  await VWO.launch(android_apiKey, vwoConfig: vwoConfig);
}
```

**Push Custom Dimension**

```dart
await VWO.pushCustomDimension("CUSTOM_DIMENSION_KEY", "CUSTOM_DIMENSION_VALUE");
```

**Get Variation Name**

```dart
await VWO.getVariationNameForTestKey("campaign_key");

```

**Get Variable Value**

```dart
//get String variable value
await VWO.getStringForKey("variable_key", "default_value")

//get Integer variable value
await VWO.getIntegerForKey("variable_key", default_value)

//get Double variable value
await VWO.getDoubleForKey("variable_key", default_value)

//get Boolean variable value
await VWO.getBooleanForKey("variable_key", default_value)

//get Object variable value
await VWO.getObjectForKey("variable_key", default_value)
```

**Trigger Goal**

```dart
//custom-goal
await VWO.trackConversion("test_goal");

//revenue-goal
await VWO.trackConversion("test_goal", revenue_value);
```



## Credentials

This SDK requires an app key. You can sign up for an account at [VWO](https://vwo.com). 
Once there, you can add a new Android/iOS App, and use the generated app key in the app.

## Setting up VWO account

* Sign Up for VWO account at https://vwo.com
* Create a new android app from create menu
* Use the app generated app key, while integrating SDK into android/iOS app.
* Create and run campaigns.


## Authors
- Main Contributor & Maintainer - [sanyamjain65](https://github.com/sanyamjain65)
- Repo health maintainer - [softvar](https://github.com/softvar)

## Changelog
Refer [CHANGELOG.md](https://github.com/wingify/vwo-flutter-sdk/blob/master/CHANGELOG.md)

## Contributing

Please go through our [contributing guidelines](https://github.com/wingify/vwo-flutter-sdk/blob/master/CONTRIBUTING.md)


## Code of Conduct

[Code of Conduct](https://github.com/wingify/vwo-flutter-sdk/blob/master/CODE_OF_CONDUCT.md)


## License

[Apache License, Version 2.0](https://github.com/wingify/vwo-flutter-sdk/blob/master/LICENSE)

Copyright 2021 Wingify Software Pvt. Ltd.