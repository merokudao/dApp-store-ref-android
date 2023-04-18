part of 'package_manager_cubit.dart';

@freezed
class PackageManagerState with _$PackageManagerState {
  const factory PackageManagerState({
    Map<String, PackageInfo>? packageMapping,
    Map<String, String>? taskIdToPackageName,
    ReceivePort? port,
  }) = _PackageManagerState;

  factory PackageManagerState.initial() => PackageManagerState(
        packageMapping: {},
        port: ReceivePort(),
        taskIdToPackageName: {},
      );
}
