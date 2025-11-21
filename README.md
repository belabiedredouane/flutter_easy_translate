
[<img src="resources/images/flutter_easy_translate.png" />](https://github.com/belabiedredouane/flutter_easy_translate)

[![pub package](https://img.shields.io/pub/v/flutter_easy_translate.svg?color=important)](https://pub.dev/packages/flutter_easy_translate)
[![License: MIT](https://img.shields.io/badge/License-MIT-ff69b4.svg)](https://github.com/belabiedredouane/flutter_easy_translate/blob/main/LICENSE)
[![Flutter.io](https://img.shields.io/badge/Flutter-Website-deepskyblue.svg)](https://flutter.io/)

---

Flutter Translate is a fully featured localization / internationalization (i18n) library for Flutter.

It lets you define translations for your content in different languages and switch between them easily.

# Features

* Very easy to use
* ```Mobile```, ```Web``` and ```Desktop``` support
* ```Pluralization``` and ```Duals``` support 
* Supports both ``languageCode (en)`` and ``languageCode_countryCode (en_US)`` locale formats 
* Automatically ```save & restore``` the selected locale [with a simple implementation](#automatically-saving-and-restoring-the-selected-locale)
* Full support for ```right-to-left``` locales
* ``Fallback`` locale support in case the system locale is unsupported
* Supports both ``inline or nested`` JSON

# Documentation

## Installation

Add this to your package's pubspec.yaml file:

```sh
dependencies:
  flutter_easy_translate: <latest version>
```

Install packages from the command line (or from your editor):

```sh
flutter pub get
```

## Configuration

Import flutter_easy_translate:

```dart
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
```

Place the *json* localization files in a folder of your choice within the project.

By default ```flutter_easy_translate``` will search for localization files in the `assets/i18n` directory in your project's root.

Declare your assets localization directory in ```pubspec.yaml```

```sh
flutter:
  assets:
    - assets/i18n/
```

In the main function create the localization delegate and start the app, wrapping it with LocalizedApp

```dart
void main() async
{
  var delegate = await LocalizationDelegate.create(
        fallbackLocale: 'en_US',
        supportedLocales: ['en_US', 'es', 'fa']);

  runApp(LocalizedApp(delegate, MyApp()));
}
```

If the assets directory for the localization files is different than the default one (```assets/i18n```), you need to specify it:

```dart
 var delegate = await LocalizationDelegate.create(
      ...
        basePath: 'assets/i18n/'
      ...
```

Example MyApp:

```dart
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Flutter Translate Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
        ),
      );
  }
}
```

## Usage

Translate a string:

```dart
translate('your.localization.key');
```

Translate with arguments;

```dart
translate('your.localization.key', args: {'argName1': argValue1, 'argName2': argValue2});
```

Translate with pluralization:

```dart
translatePlural('plural.demo', yourNumericValue);
```

JSON:

```json
"plural": {
    "demo": {
       "zero": "Please start pushing the 'plus' button.",
	"one": "You have pushed the button one time.",
	"two": "You have pushed the button two times.",
	"other": "You have pushed the button {{value}} times."
    }
}
```

Change the language:

```dart
@override
Widget build(BuildContext context) {
...
  ...
    changeLocale(context, 'en_US');
  ...
...
}
```

# Automatically saving and restoring the selected locale
[Flutter Easy Translate](https://github.com/belabiedredouane/flutter_easy_translate) can automatically save the selected locale and restore it after application restart.

This can be done by passing an implementation of [ITranslatePreferences](https://github.com/belabiedredouane/flutter_easy_translate/blob/main/lib/src/interfaces/translate_preferences.dart) during delegate creation:

```dart
 var delegate = await LocalizationDelegate.create(
      ...
        preferences: TranslatePreferences()
      ...
```

Example implementation using the [shared_preferences](https://pub.dev/packages/shared_preferences) package:

```dart
import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslatePreferences implements ITranslatePreferences
{
    static const String _selectedLocaleKey = 'selected_locale';

    @override
    Future<Locale> getPreferredLocale() async
    {
        final preferences = await SharedPreferences.getInstance();

        if(!preferences.containsKey(_selectedLocaleKey)) return null;

        var locale = preferences.getString(_selectedLocaleKey);

        return localeFromString(locale);
    }

    @override
    Future savePreferredLocale(Locale locale) async
    {
        final preferences = await SharedPreferences.getInstance();

        await preferences.setString(_selectedLocaleKey, localeToString(locale));
    }
}
```

And don't forget to reference the shared_preferences package in pubspec.yaml

```dart
dependencies:
  shared_preferences: <latest version>
```

## Example

https://github.com/belabiedredouane/flutter_easy_translate/tree/main/example

## Issues
Please file any issues, bugs or feature request [here](https://github.com/belabiedredouane/flutter_easy_translate/issues).

## License

This project is licensed under the [MIT License](https://github.com/belabiedredouane/flutter_easy_translate/blob/main/LICENSE)