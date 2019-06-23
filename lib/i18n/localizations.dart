import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rann_github/i18n/strings_base.dart';
import 'package:rann_github/i18n/strings_en.dart';
import 'package:rann_github/i18n/strings_zh.dart';

class HubLocalizationsDelegate extends LocalizationsDelegate<HubLocalizations> {
  HubLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<HubLocalizations> load(Locale locale) {
    return SynchronousFuture<HubLocalizations>(HubLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<HubLocalizations> old) {
    return false;
  }

  static HubLocalizationsDelegate delegate = HubLocalizationsDelegate();
}

class HubLocalizations {
  final Locale locale;
  HubLocalizations(this.locale);

  static Map<String, HubStringsBase> _localizedValues = {
    'en': HubStringsEn(),
    'zh': HubStringsZh()
  };

  HubStringsBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  static HubLocalizations of(BuildContext context) {
    return Localizations.of(context, HubLocalizations);
  }
}
