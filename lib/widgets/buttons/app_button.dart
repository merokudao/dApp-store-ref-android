import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart';
import 'package:dappstore/widgets/buttons/app_button_handler/i_app_button_handler.dart';
import 'package:dappstore/widgets/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:version/version.dart';

// ignore: must_be_immutable
class AppButton extends StatefulWidget {
  /// A button that can handle install, update, openDapp, openPwa, saveDapp, unsaveDapp and more functionality
  /// with custom designs params [theme]
  final IThemeSpec theme;
  final DappInfo dappInfo;
  late IAppButtonHandler appButtonHandler;
  late IPackageManager packageManager;
  final double radius;
  final double height;
  final double width;
  final bool showPrimary;
  final bool showSecondary;

  AppButton({
    Key? key,
    required this.theme,
    required this.dappInfo,
    required this.radius,
    required this.height,
    required this.width,
    this.showPrimary = true,
    this.showSecondary = true,
  }) : super(key: key) {
    appButtonHandler = getIt<IAppButtonHandler>();
    packageManager = appButtonHandler.packageManager;
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ISavedPwaCubit, SavedPwaState>(
        bloc: widget.appButtonHandler.savedPwaCubit,
        buildWhen: (previous, current) {
          return previous.savedDapps[widget.dappInfo.dappId!] !=
              current.savedDapps[widget.dappInfo.dappId!];
        },
        builder: (BuildContext context, savedPwaState) {
          final savedDapp = savedPwaState.savedDapps[widget.dappInfo.dappId];
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
              final packageInfo = state.packageMapping![
                  widget.dappInfo.packageId ?? widget.dappInfo.dappId];
              if (((packageInfo?.status == DownloadTaskStatus.enqueued) ||
                      (packageInfo?.status == DownloadTaskStatus.running) ||
                      (packageInfo?.progress != 100 &&
                          packageInfo?.progress != null)) &&
                  !(packageInfo?.status == DownloadTaskStatus.failed ||
                      packageInfo?.status == DownloadTaskStatus.undefined)) {
                return CircularProgressIndicator.adaptive(
                  backgroundColor: widget.theme.greyBlue,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.theme.blue),
                );
              } else if (packageInfo?.status == DownloadTaskStatus.complete &&
                  (packageInfo?.installing ?? false)) {
                return CustomElevatedButton(
                  onTap: () {},
                  color: widget.theme.ratingGrey,
                  radius: widget.radius,
                  width: widget.width,
                  height: widget.height,
                  child: Text(
                    context.getLocale!.installing,
                    style: widget.theme.normalTextStyle,
                  ),
                );
              } else if (!(packageInfo?.installed ?? false) &&
                  (widget.dappInfo.availableOnPlatform?.contains("android") ??
                      false) &&
                  (widget.dappInfo.packageId != null)) {
                return CustomElevatedButton(
                  onTap: () {
                    widget.appButtonHandler
                        .startDownload(widget.dappInfo, context);
                  },
                  color: widget.theme.blue,
                  radius: widget.radius,
                  width: widget.width,
                  height: widget.height,
                  child: Text(
                    context.getLocale!.download,
                    style: widget.theme.normalTextStyle,
                  ),
                );
              } else if (!(widget.dappInfo.availableOnPlatform
                      ?.contains("android") ??
                  false)) {
                return SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.showSecondary)
                        savedDapp == null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: widget.width,
                                  height: widget.height,
                                  child: TextButton(
                                    onPressed: () {
                                      widget.appButtonHandler
                                          .saveDapp(widget.dappInfo);
                                    },
                                    style: TextButton.styleFrom(
                                      // foregroundColor: theme.appGreen,
                                      backgroundColor: Colors.transparent,
                                      // shadowColor: theme.appGreen,
                                      // surfaceTintColor: theme.appGreen,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: widget.theme.appGreen,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          widget.radius,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      context.getLocale!.save,
                                      style: widget.theme.redButtonText
                                          .copyWith(
                                              color: widget.theme.appGreen),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: widget.width,
                                  height: widget.height,
                                  child: TextButton(
                                    onPressed: () {
                                      widget.appButtonHandler
                                          .unsaveDapp(widget.dappInfo);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: widget.theme.buttonRed,
                                      backgroundColor: Colors.black,
                                      surfaceTintColor: widget.theme.buttonRed,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: widget.theme.buttonRed,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          widget.radius,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      context.getLocale!.remove,
                                      style: widget.theme.redButtonText,
                                    ),
                                  ),
                                ),
                              ),
                      if (widget.showPrimary)
                        CustomElevatedButton(
                          onTap: () {
                            widget.appButtonHandler
                                .openPwaApp(context, widget.dappInfo);
                          },
                          color: widget.theme.blue,
                          radius: widget.radius,
                          width: widget.width,
                          height: widget.height,
                          child: Text(
                            context.getLocale!.openDapp,
                            style: widget.theme.normalTextStyle,
                          ),
                        )
                    ],
                  ),
                );
              } else if ((packageInfo?.installed ?? false) &&
                  (Version.parse(packageInfo?.versionName ?? "0.0.0")) <
                      Version.parse(
                          widget.dappInfo.version?.replaceAll("v", "") ??
                              "0.0.0")) {
                return SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.showSecondary)
                        SizedBox(
                          width: widget.width,
                          height: widget.height,
                          child: TextButton(
                              onPressed: () {
                                widget.appButtonHandler
                                    .startDownload(widget.dappInfo, context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: widget.theme.buttonBlue,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: widget.theme.buttonBlue),
                                  borderRadius: BorderRadius.circular(
                                    widget.radius,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  context.getLocale!.update,
                                  style: widget.theme.normalTextStyle.copyWith(
                                    color: widget.theme.buttonBlue,
                                  ),
                                ),
                              )),
                        ),
                      if (widget.showPrimary)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            onTap: () {
                              widget.appButtonHandler.openApp(widget.dappInfo);
                            },
                            color: widget.theme.blue,
                            radius: widget.radius,
                            width: widget.width,
                            height: widget.height,
                            child: Text(
                              context.getLocale!.open,
                              style: widget.theme.normalTextStyle,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              } else if (packageInfo?.installed ?? false) {
                return CustomElevatedButton(
                  onTap: () {
                    widget.appButtonHandler.openApp(widget.dappInfo);
                  },
                  color: widget.theme.blue,
                  radius: widget.radius,
                  width: widget.width,
                  height: widget.height,
                  child: Text(
                    context.getLocale!.openDapp,
                    style: widget.theme.normalTextStyle,
                  ),
                );
              }
              return const SizedBox();
            },
          );
        });
  }
}
