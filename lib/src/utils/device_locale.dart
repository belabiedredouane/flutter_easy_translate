import 'package:flutter/widgets.dart';
import 'package:intl/intl_default.dart'
    if (dart.library.js_interop) 'package:intl/intl_browser.dart'
    if (dart.library.io) 'package:intl/intl_standalone.dart';

/// Returns the current device locale
Future<Locale?> getCurrentLocale() async {
  final foundPlatformLocale = await findSystemLocale();
  return _localeFromString(foundPlatformLocale);
}

Locale? _localeFromString(String code) {
  var separator = code.contains('_')
      ? '_'
      : code.contains('-')
          ? '-'
          : null;

  if (separator != null) {
    var parts = code.split(RegExp(separator));

    return Locale(parts[0], parts[1]);
  } else {
    return Locale(code);
  }
}
