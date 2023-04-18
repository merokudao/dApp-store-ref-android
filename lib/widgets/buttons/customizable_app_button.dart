import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart';
import 'package:dappstore/widgets/buttons/app_button_handler/i_app_button_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:version/version.dart';

// ignore: must_be_immutable
class CustomizableAppButton extends StatefulWidget {
  /// A custom app button that can handle install, update or openDapp functionality
  /// with custom designs params [theme]
  final IThemeSpec theme;
  final DappInfo dappInfo;
  late IAppButtonHandler appButtonHandler;
  late IPackageManager packageManager;
  final Widget updateWidget;
  final Widget openWidget;
  final Widget installWidget;
  final Widget installingWidget;
  final Widget? progressIndicator;
  final Function? customDownloadFunction;

  CustomizableAppButton({
    Key? key,
    required this.theme,
    required this.dappInfo,
    required this.updateWidget,
    required this.openWidget,
    required this.installWidget,
    required this.installingWidget,
    this.progressIndicator,
    this.customDownloadFunction,
  }) : super(key: key) {
    appButtonHandler = getIt<IAppButtonHandler>();
    packageManager = appButtonHandler.packageManager;
  }

  @override
  State<CustomizableAppButton> createState() => _CustomizableAppButtonState();
}

class _CustomizableAppButtonState extends State<CustomizableAppButton> {
  late IThemeSpec theme;
  late CircularProgressIndicator circularProgressIndicator;
  late DappInfo dappInfo;
  @override
  void initState() {
    theme = widget.theme;
    circularProgressIndicator = CircularProgressIndicator.adaptive(
      backgroundColor: theme.greyBlue,
      valueColor: AlwaysStoppedAnimation<Color>(theme.blue),
    );
    dappInfo = widget.dappInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ISavedPwaCubit, SavedPwaState>(
        bloc: widget.appButtonHandler.savedPwaCubit,
        buildWhen: (previous, current) {
          return previous.savedDapps[widget.dappInfo.dappId!] !=
              current.savedDapps[widget.dappInfo.dappId!];
        },
        builder: (BuildContext context, savedPwaState) {
          return BlocBuilder<IPackageManager, PackageManagerState>(
            bloc: widget.packageManager,
            buildWhen: (previous, current) {
              return (previous.packageMapping![widget.dappInfo.packageId!] !=
                      current.packageMapping![widget.dappInfo.packageId!] ||
                  previous.packageMapping![widget.dappInfo.packageId!]
                          ?.status !=
                      current.packageMapping![widget.dappInfo.packageId!]
                          ?.status ||
                  previous.packageMapping![widget.dappInfo.packageId!]
                          ?.progress !=
                      current.packageMapping![widget.dappInfo.packageId!]
                          ?.progress ||
                  previous.packageMapping![widget.dappInfo.packageId!]
                          ?.installing !=
                      current.packageMapping![widget.dappInfo.packageId!]
                          ?.installing);
            },
            builder: (context, state) {
              final package = state.packageMapping![dappInfo.packageId];
              if ((dappInfo.availableOnPlatform?.contains("web") ?? false) &&
                  !(dappInfo.availableOnPlatform?.contains("android") ??
                      false)) {
                return InkWell(
                  onTap: () {
                    widget.appButtonHandler
                        .openPwaApp(context, widget.dappInfo);
                  },
                  child: widget.openWidget,
                );
              }
              if (dappInfo.availableOnPlatform?.contains("android") ?? false) {
                if (((package?.status == DownloadTaskStatus.enqueued) ||
                        (package?.status == DownloadTaskStatus.running) ||
                        (package?.progress != 100 &&
                            package?.progress != null)) &&
                    !(package?.status == DownloadTaskStatus.failed ||
                        package?.status == DownloadTaskStatus.undefined)) {
                  return widget.progressIndicator ?? circularProgressIndicator;
                }
                if ((package?.installing ?? false)) {
                  return widget.installingWidget;
                }
                if (!(state.packageMapping![dappInfo.packageId]?.installed ??
                    false)) {
                  return InkWell(
                    onTap: () {
                      if (widget.customDownloadFunction != null) {
                        widget.customDownloadFunction!.call();
                      } else {
                        widget.appButtonHandler
                            .startDownload(widget.dappInfo, context);
                      }
                    },
                    child: widget.installWidget,
                  );
                } else {
                  var installedVersion = Version.parse("0.0.0");

                  var availableVersion = Version.parse("0.0.0");

                  try {
                    installedVersion =
                        Version.parse(package?.versionName ?? "0.0.0");
                    availableVersion = Version.parse(
                        dappInfo.version?.replaceAll("v", "") ?? "0.0.0");
                  } catch (_) {}

                  if (installedVersion < availableVersion) {
                    return InkWell(
                      onTap: () {
                        if (widget.customDownloadFunction != null) {
                          widget.customDownloadFunction!.call();
                        } else {
                          widget.appButtonHandler
                              .startDownload(widget.dappInfo, context);
                        }
                      },
                      child: widget.updateWidget,
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        widget.appButtonHandler.openApp(widget.dappInfo);
                      },
                      child: widget.openWidget,
                    );
                  }
                }
              }
              return const SizedBox();
            },
          );
        });
  }
}
