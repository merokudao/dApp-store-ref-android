import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocaleExtension on BuildContext {
  AppLocalizations? get getLocale => AppLocalizations.of(this);
}
