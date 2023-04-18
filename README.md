# DappStore

## Authors

- Akshit Ostwal [Github](https://github.com/AkshitOstwal) [Twitter](https://twitter.com/Akshitostwal)
- Abhimanyu Shekhawat [Github](https://github.com/abhimanyu121) [Twitter](https://twitter.com/sokkkkaaa)

<br>

## Requirements

### • Flutter SDK

<br>

```
flutter --version
```

```
Flutter 3.3.9 • channel stable • https://github.com/flutter/flutter.git
Framework • revision b8f7f1f986 (4 months ago) • 2022-11-23 06:43:51 +0900
Engine • revision 8f2221fbef
Tools • Dart 2.18.5 • DevTools 2.15.0
```

<br>

## How to run

- `flutter pub get`
- `flutter pub run build_runner build --delete-conflicting-outputs`
- `flutter run`

<br>

## Before you start building

- Goto **/lib/config/config.dart** and update `Config.sentryDSN`, `WalletConnectConfig.projectId` and `WalletConnectConfig.metadata` with your own configuration before start building on top of this repo.

- Goto **/lib/config/config.dart** and Change `Config.customApiBaseUrl` and change it to you own hosted Backend base URI

<br>

## Structure Overview

### Core

- **/config** - Configurations like API endpoints, projectID, URL etc
- **/core** - Core utilities like network, storage, di, error, localization, router, etc. being used app-wide.
- **/core/application** - Base App and necessary dependencies.
- **/core/application/init** - Initialise utilities that need to started before runApp().
- **/core/di** - Dependency injectoion used inside the app.
- **/core/error** - Check for network availability. Ex - throw SomeException();
  - Exceptions - Classes used for throwing exceptions on root layer.
  - Failures - Classes used for returning failures or errors on repository level. Ex - Either<SomeFailure, Unit> someFunc() {}
- **/core/installed_apps** - Logic to check for installed app on the device, that can be used thorughout the app.
- **/core/localisation** - Logic regarding the device locale and changing locale.
- **/core/network** - Network requests client wrapper.
- **/core/permissions** - App permission cubit and states.
- **/core/platform_channel** - Native android task that are done through platform channels foes here, like intalling apps.
- **/core/router** - Navigation router wrapper for customised routing and adding custom route observer.
- **/core/signer** - Signer interface.
- **/core/store** - Cache store classes.
- **/core/theme** - Theme related models, cubit and states.

### Features

- **/features** - Feature implementations.
- **/features/feature_name** - Feature specific implementations.
- **/features/feature_name/application** - Controller or state-mangement utilities.
- **/features/feature_name/application/handler** - All the on-tap, on-click handler function used in UI.
- **/features/feature_name/application/cubit** - Bloc/Cubit state-mangement utilities.
  - Cubit interface
  - Cubit implementations
  - States
- **/features/feature_name/domain** - Data Models and base repository implementations.
- **/features/feature_name/domain/entities** - Feature specific data models.
- **/features/feature_name/domain/repositories** - Repository interfaces.
- **/features/feature_name/infrastructure** - All functionality related to fetching, storing, caching, retrieving local or remote data and necessary json classes.
- **/features/feature_name/infrastructure/datasources**
  - Interface
  - Local Data source
  - Remote Data source
- **/features/feature_name/infrastructure/dtos** - Data Transfer Objects that hold Json data models and functions to convert to domain entities.
- **/features/feature_name/infrastructure/respositories** - Unifying all datasources at repository layer to be accessed by any controller or state-management.
- **/features/feature_name/presentation** - Everything UI related.
  - Screens
  - Widgets
- **/features/feature_name/presentation/screen** - Top level screens for the feature.
- **/features/feature_name/presentation/widgeta** - Any widgets that are used inside the screens.

### Generated

- **/generated** Stores all the generated file like .freezed.dart , .g.dart and others

### Localization

This project generates localized messages based on arb files found in
the `lib/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

### Utils

- **/utils** All the appwide used utilities files/funcitons.

### Widgets

- **/widgets** All the appwide used widgets.
- **/widgets/widget_type** All the appwide widget of a certain type like buttons, loader, bottom_sheet, etc.

### Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains images

The `assets/icons` directory contains icons

The `assets/fonts` directory contains fonts used

<br>

## Commands Run in CI

- `flutter analyze`
- `dart format --output=none --set-exit-if-changed .`

<br>

## Useful Commands

- `flutter pub run build_runner build --delete-conflicting-outputs` - Regenerates JSON Generators
- `flutter doctor -v` - get paths of everything installed.
- `flutter pub get`
- `flutter upgrade`
- `flutter clean`
- `flutter pub cache clean`
- `flutter pub deps`
- `flutter pub run dependency_validator` - show unused dependencies and more
- `flutter analyze`
