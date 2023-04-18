import 'dart:io';
import 'dart:ui';

import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/localisation/store/i_localisation_store.dart';
import 'package:dappstore/core/localisation/store/localisation_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part '../../generated/core/localisation/localisation_cubit.freezed.dart';
part 'localisation_state.dart';

//this cubit can be used to handle setting custom localisation
//right now we are only following system though
@LazySingleton(as: ILocaleCubit)
class LocaleCubit extends Cubit<LocaleState> implements ILocaleCubit {
  final ILocalisationStore localisationStore;
  LocaleCubit({required this.localisationStore}) : super(LocaleState.initial());
  @override
  initialise() async {
    final locale = await getLocale();
    final shouldFollowSystem = await _shouldFollowSystem();
    emit(state.copyWith(
      shouldFollowSystem: shouldFollowSystem,
      activeLocale: locale,
    ));
  }

  @override
  setLocale(String locale) {
    emit(state.copyWith(activeLocale: locale));
    _updateLocale(locale);
  }

  @override
  toggleShouldFollowSystem(bool shouldFollowSystem) async {
    await _updateShouldFollowSystem(shouldFollowSystem);
    emit(state.copyWith(shouldFollowSystem: shouldFollowSystem));
  }

  @override
  bool get shouldFollowSystem => state.shouldFollowSystem ?? false;

  @override
  Locale getLocaleToUse() {
    if (shouldFollowSystem) {
      return Locale(Platform.localeName);
    } else {
      return Locale(state.activeLocale ?? LocalisationStore.defaultLocale);
    }
  }

  _updateLocale(String locale) async {
    await localisationStore.setLocale(locale);
  }

  _updateShouldFollowSystem(bool shouldFollowSystem) async {
    await localisationStore.setShouldFollowSystem(shouldFollowSystem);
    emit(state.copyWith(shouldFollowSystem: shouldFollowSystem));
  }

  _shouldFollowSystem() async {
    return await localisationStore.isShouldFollowSystem();
  }

  Future<String> getLocale() async {
    final locale = await localisationStore.locale();
    return locale;
  }

  @override
  localeList() {
    return AppLocalizations.supportedLocales;
  }
}
