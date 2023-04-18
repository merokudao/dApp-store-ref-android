import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

abstract class IDownloader {
  Future<void> initialize();

  initializeStorageDir();

  Future<TaskInfo?> requestDownload(TaskInfo task);

  Future<void> pauseDownload(TaskInfo task);

  Future<void> resumeDownload(TaskInfo task);

  Future<void> retryDownload(TaskInfo task);

  Future<bool> openDownloadedFile(TaskInfo? task);

  Future<TaskInfo?> findById(String id);

  Future<List<DownloadTask>?> getAllDownloads();

  Future<void> addOnComplete(TaskInfo task);

  Future<void> delete(TaskInfo task);

  String? get saveDir;

  void getDataFromBgIsolate(
    String taskId,
    DownloadTaskStatus status,
    int progress,
  );
}
