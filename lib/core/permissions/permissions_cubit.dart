import 'dart:io';

import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notification_permissions/notification_permissions.dart'
    as n_perm;
import 'package:permission_handler/permission_handler.dart';

part '../../generated/core/permissions/permissions_cubit.freezed.dart';
part 'permissions_state.dart';

//this cubit checks for permissions and wraps around permission handler to request permission
@LazySingleton(as: IPermissions)
class Permissions extends Cubit<PermissionsState> implements IPermissions {
  Permissions() : super(PermissionsState.initial());

  @override
  Future<void> checkAllPermissions() async {
    await checkStoragePermission();
    await checkAppInstallationPermissions();
    await checkNotificationPermission();
  }

  /// To check if user have given storage permission or not
  @override
  Future<PermissionStatus> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 28) {
        emit(state.copyWith(storagePermission: PermissionStatus.granted));

        return PermissionStatus.granted;
      }
    }
    final status = await Permission.storage.status;
    emit(state.copyWith(storagePermission: status));
    return status;
  }

  /// To check if user have given app installation permission or not
  @override
  Future<PermissionStatus?> checkAppInstallationPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.requestInstallPackages.status;
      emit(state.copyWith(appInstallation: status));

      return status;
    }
    return null;
  }

  /// To check if user have given notification permission or not
  @override
  Future<PermissionStatus> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    emit(state.copyWith(notificationPermission: status));
    return status;
  }

  /// To request storage permission from user
  @override
  Future<PermissionStatus> requestStoragePermission() async {
    final result = await Permission.storage.request();
    emit(state.copyWith(storagePermission: result));
    return result;
  }

  /// To request notification permission from user
  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    // final result = await Permission.notification.request();
    // emit(state.copyWith(notificationPermission: result));
    // return result;
    n_perm.PermissionStatus permissionStatus =
        await n_perm.NotificationPermissions.requestNotificationPermissions();
    PermissionStatus perm = PermissionStatus.denied;
    if (permissionStatus == n_perm.PermissionStatus.granted) {
      perm = PermissionStatus.granted;
    } else if (permissionStatus == n_perm.PermissionStatus.denied) {
      perm = PermissionStatus.denied;
    } else if (permissionStatus == n_perm.PermissionStatus.provisional) {
      perm = PermissionStatus.limited;
    }
    emit(state.copyWith(notificationPermission: perm));
    return perm;
  }

  /// To request app installation permission from user
  @override
  Future<PermissionStatus?> requestAppInstallationPermission() async {
    if (Platform.isAndroid) {
      final result = await Permission.requestInstallPackages.request();
      emit(state.copyWith(appInstallation: result));
      return result;
    }
    return null;
  }

  @override
  changeShowingInstallDialog(bool value) {
    emit(state.copyWith(isShowingInstallDialog: value));
  }

  @override
  changeShowingNotificationDialog(bool value) {
    emit(state.copyWith(isShowingNotificationDialog: value));
  }

  @override
  changeShowingStorageDialog(bool value) {
    emit(state.copyWith(isShowingStorageDialog: value));
  }
}
