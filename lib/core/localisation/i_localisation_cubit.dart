import 'dart:ui';

import 'package:dappstore/core/localisation/localisation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ILocaleCubit extends Cubit<LocaleState> {
  ILocaleCubit() : super(LocaleState.initial());

  initialise();

  setLocale(String locale);

  localeList();

  bool get shouldFollowSystem;

  Locale getLocaleToUse();

  toggleShouldFollowSystem(bool shouldFollowSystem);
}
