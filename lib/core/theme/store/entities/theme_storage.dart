import 'package:hive_flutter/hive_flutter.dart';

part '../../../../generated/core/theme/store/entities/theme_storage.g.dart';

@HiveType(typeId: 1)
class ThemeStorage extends HiveObject {
  ThemeStorage({this.isDarkEnabled, this.shouldFollowSystem});
  @HiveField(0)
  bool? isDarkEnabled;
  @HiveField(1)
  bool? shouldFollowSystem;
}
