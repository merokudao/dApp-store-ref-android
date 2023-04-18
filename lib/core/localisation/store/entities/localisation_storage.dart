import 'package:hive_flutter/hive_flutter.dart';

part '../../../../generated/core/localisation/store/entities/localisation_storage.g.dart';

@HiveType(typeId: 2)
class LocalisationStorage extends HiveObject {
  LocalisationStorage({this.locale, this.shouldFollowSystem});
  @HiveField(0)
  String? locale;
  @HiveField(1)
  bool? shouldFollowSystem;
}
