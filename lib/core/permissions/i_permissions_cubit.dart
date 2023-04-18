import 'package:dappstore/core/permissions/permissions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IPermissions extends Cubit<PermissionsState> {
  IPermissions() : super(PermissionsState.initial());

  Future<void> checkAllPermissions();

  Future<PermissionStatus> checkStoragePermission();

  Future<PermissionStatus> requestStoragePermission();

  Future<PermissionStatus?> checkAppInstallationPermissions();

  Future<PermissionStatus> checkNotificationPermission();

  Future<PermissionStatus?> requestAppInstallationPermission();

  Future<PermissionStatus> requestNotificationPermission();

  changeShowingInstallDialog(bool value);
  changeShowingNotificationDialog(bool value);
  changeShowingStorageDialog(bool value);
}
