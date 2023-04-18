import 'dart:isolate';

import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/datasources/downloader.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part '../../../../../generated/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.freezed.dart';
part 'downloader_state.dart';

@LazySingleton(as: IDownloader)
class DownloaderCubit extends Cubit<DownloaderState> implements IDownloader {
  final IPermissions permissionsCubit;
  final IInstallerCubit installerCubit;
  DownloaderCubit(
      {required this.permissionsCubit, required this.installerCubit})
      : super(DownloaderState.initial());

  @override
  Future<void> initialize() async {
    await Downloader.initialize(Downloader.downloadCallback);
    //_bindBackgroundIsolate();
  }

  @override
  initializeStorageDir() async {
    final storagePerms = await _checkStorage();
    if (storagePerms && state.storageInitialized != true) {
      final saveDir = await Downloader.getSavedDir();
      final status = await Downloader.initializeStorageDir(
          state.storageInitialized, saveDir!);
      emit(state.copyWith(
        storageInitialized: status,
        localPath: saveDir,
      ));
    }
  }

  @override
  void getDataFromBgIsolate(
    String taskId,
    DownloadTaskStatus status,
    int progress,
  ) {
    debugPrint(
      'Callback on UI isolate: '
      'task ($taskId) is in status ($status) and process ($progress)',
    );
    debugPrint("State: ${state.tasks}");
    if (state.tasks != null && state.tasks!.isNotEmpty) {
      final task = state.tasks![taskId];
      if (task != null) {
        // ignore: unused_result
        task.copyWith(status: status, progress: progress);
        Map<String, TaskInfo> tasks = {...state.tasks!};
        tasks[taskId] = task;
        emit(state.copyWith(tasks: tasks));
      }
    }
  }

  @override
  Future<TaskInfo?> requestDownload(TaskInfo task) async {
    final storagePerms = await _checkStorage();
    debugPrint('StoragePermission: $storagePerms');
    if (storagePerms && (state.storageInitialized ?? false)) {
      final queuedTask = await Downloader.requestDownload(
          task, state.storageInitialized ?? false, state.localPath!);
      Map<String, TaskInfo> tasks_ = {...state.tasks!};
      if (queuedTask != null) {
        tasks_[queuedTask.taskId!] = queuedTask;
        emit(state.copyWith(tasks: tasks_));
      }
      return queuedTask;
    }
    return null;
  }

  @override
  Future<void> pauseDownload(TaskInfo task) async {
    await Downloader.pauseDownload(task);
  }

  @override
  Future<List<DownloadTask>?> getAllDownloads() async {
    return await Downloader.getAllDownloads();
  }

  @override
  Future<void> addOnComplete(TaskInfo task) async {
    //await Downloader.addDownloadOnComplete(task);
  }

  @override
  Future<void> resumeDownload(TaskInfo task) async {
    await Downloader.resumeDownload(task);
  }

  @override
  Future<TaskInfo?> findById(String id) async {
    return state.tasks![id];
  }

  @override
  Future<void> retryDownload(TaskInfo task) async {
    await Downloader.retryDownload(task);
  }

  @override
  Future<bool> openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return Downloader.openDownloadedFile(task);
  }

  @override
  Future<void> delete(TaskInfo task) async {
    Downloader.delete(task);
    final saveDir = await Downloader.getSavedDir();

    final Map<String, TaskInfo> tasks = await Downloader.prepare(saveDir!);
    final storagePerms = await _checkStorage();
    if (storagePerms) {
      await Downloader.prepareSaveDir(saveDir);
    }
    emit(state.copyWith(tasks: tasks));
  }

  @override
  String? get saveDir => state.localPath;
  Future<bool> _checkStorage() async {
    final storagePermission = await permissionsCubit.checkStoragePermission();
    return storagePermission == PermissionStatus.granted;
  }
}
