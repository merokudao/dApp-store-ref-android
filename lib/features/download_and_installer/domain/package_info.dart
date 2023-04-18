import 'dart:typed_data';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../generated/features/download_and_installer/domain/package_info.freezed.dart';

@freezed
class PackageInfo with _$PackageInfo {
  const factory PackageInfo({
    String? name,
    Uint8List? icon,
    String? packageName,
    String? versionName,
    double? versionCode,
    bool? installed,
    bool? installing,
    String? taskId,
    String? url,
    String? fileName,
    String? saveDir,
    bool? autoInstall,
    @Default(0) int? progress,
    @Default(DownloadTaskStatus.undefined) DownloadTaskStatus? status,
  }) = _PackageInfo;
}
