import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../generated/features/download_and_installer/infrastructure/dtos/task_info.freezed.dart';

@freezed
class TaskInfo with _$TaskInfo {
  const factory TaskInfo({
    String? name,
    String? link,
    String? taskId,
    String? saveDir,
    String? fileName,
    @Default(0) int? progress,
    @Default(DownloadTaskStatus.undefined) DownloadTaskStatus? status,
  }) = _TaskInfo;
}
