part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    PermissionStatus? storagePermission,
    PermissionStatus? appInstallation,
    PermissionStatus? notificationPermission,
    required bool isShowingInstallDialog,
    required bool isShowingNotificationDialog,
    required bool isShowingStorageDialog,
  }) = _PermissionsState;

  factory PermissionsState.initial() => const PermissionsState(
        isShowingInstallDialog: false,
        isShowingNotificationDialog: false,
        isShowingStorageDialog: false,
      );
}
