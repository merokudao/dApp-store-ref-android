import 'dart:io';
import 'dart:ui';

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

typedef DownloadCallBackType = void Function(
    String id, DownloadTaskStatus status, int progress);
typedef OnCompleteCallback = void Function(TaskInfo taskInfo);

class Downloader {
  static const uiCallBackPort = 'downloader_sendstate.port';
  static IErrorLogger errorLogger = getIt<IErrorLogger>();
  static IInstallerCubit installerCubit = getIt<IInstallerCubit>();
  static Future<void> initialize(DownloadCallBackType downloadCallback) async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  //creates storage dir if it doesn't exist sets state
  static Future<bool> initializeStorageDir(
      bool? isStorageInitialized, String saveDir) async {
    try {
      await prepareSaveDir(saveDir);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  //adds to download queue, only one file is downloaded at a time to avoid certain race condition
  static Future<TaskInfo?> requestDownload(
    TaskInfo task,
    bool isStorageInitialized,
    String localPath,
  ) async {
    try {
      final taskId = await FlutterDownloader.enqueue(
        url: task.link!,
        fileName: task.fileName,
        savedDir: localPath,
        saveInPublicStorage: false,
        timeout: 15000000,
        headers: {
          "connection": "close",
        },
      );

      return task.copyWith(taskId: taskId, saveDir: localPath);
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  static Future<bool> pauseDownload(TaskInfo task) async {
    try {
      await FlutterDownloader.pause(taskId: task.taskId!);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  static Future<bool> resumeDownload(TaskInfo task) async {
    try {
      await FlutterDownloader.resume(taskId: task.taskId!);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  static Future<List<DownloadTask>?> getAllDownloads() async {
    try {
      return await FlutterDownloader.loadTasks();
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return [];
    }
  }

  static Future<bool> retryDownload(TaskInfo task) async {
    try {
      await FlutterDownloader.retry(taskId: task.taskId!);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  static Future<bool> openDownloadedFile(TaskInfo? task) async {
    try {
      final taskId = task?.taskId;
      if (taskId == null) {
        return false;
      }
      return FlutterDownloader.open(taskId: taskId);
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  static Future<bool> delete(TaskInfo task) async {
    try {
      await FlutterDownloader.remove(
        taskId: task.taskId!,
        shouldDeleteContent: true,
      );
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  static Future<Map<String, TaskInfo>> prepare(String saveDir) async {
    try {
      final tasks = await FlutterDownloader.loadTasks();

      if (tasks == null) {
        debugPrint('No tasks were retrieved from the database.');
        return {};
      }

      final Map<String, TaskInfo> tasks_ = {};

      for (final task in tasks) {
        tasks_[task.taskId] = TaskInfo(
          taskId: task.taskId,
          progress: task.progress,
          link: task.url,
          status: task.status,
          saveDir: task.savedDir,
        );
      }
      await prepareSaveDir(saveDir);
      return tasks_;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return {};
    }
  }

  static Future<bool> addDownloadOnComplete(
      TaskInfo task, DownloadCallBackType callBack) async {
    try {
      await FlutterDownloader.registerCallback(callBack);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  static Future<bool> prepareSaveDir(String saveDir) async {
    try {
      final localPath = saveDir;
      final savedDir = Directory(localPath);
      if (!savedDir.existsSync()) {
        await savedDir.create();
      }
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  //uses android data dir
  static Future<String?> getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        final directory = await getExternalStorageDirectories();
        externalStorageDirPath = directory?.first.path;
      } catch (err, st) {
        errorLogger.logError(err, st);

        debugPrint('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      try {
        externalStorageDirPath =
            (await getApplicationDocumentsDirectory()).absolute.path;
      } catch (err, st) {
        errorLogger.logError(err, st);

        debugPrint('failed to get downloads path: $err, $st');
      }
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  //call back to ui thread of flutter to update status of downloads
  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) async {
    debugPrint(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName(uiCallBackPort)
        ?.send([id, status, progress]);
  }
}
