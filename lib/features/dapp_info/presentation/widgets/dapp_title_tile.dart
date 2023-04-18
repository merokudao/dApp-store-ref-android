import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_title_tile_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:dappstore/widgets/buttons/app_button.dart';
import 'package:dappstore/widgets/buttons/elevated_button.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:version/version.dart';

// ignore: must_be_immutable
class DappTitleTile extends StatelessWidget {
  final DappInfo dappInfo;
  final IThemeSpec theme;
  final bool primaryTile;
  IDappTitleTileHandler dappTitleTileHandler = getIt<IDappTitleTileHandler>();
  DappTitleTile(
      {super.key,
      required this.theme,
      required this.dappInfo,
      required this.primaryTile});

  @override
  Widget build(BuildContext context) {
    final openButton = CustomElevatedButton(
      onTap: () {
        if (dappInfo.availableOnPlatform?.contains("android") ?? false) {
          dappTitleTileHandler.openApp(dappInfo);
        } else {
          dappTitleTileHandler.openPwaApp(context, dappInfo);
        }
      },
      color: theme.blue,
      radius: 4,
      width: 90,
      height: 28,
      child: Text(
        context.getLocale!.openDapp,
        style: theme.normalTextStyle,
      ),
    );
    final installButton = CustomElevatedButton(
      onTap: () {
        dappTitleTileHandler.startDownload(dappInfo, context);
      },
      color: theme.blue,
      radius: 4,
      width: 90,
      height: 28,
      child: Text(
        context.getLocale!.download,
        style: theme.normalTextStyle,
      ),
    );

    final installingButton = CustomElevatedButton(
      onTap: () {},
      color: theme.ratingGrey,
      radius: 4,
      width: 90,
      height: 28,
      child: Text(
        context.getLocale!.installing,
        style: theme.normalTextStyle,
      ),
    );
    final circularProgressIndicator = CircularProgressIndicator.adaptive(
      backgroundColor: theme.greyBlue,
      valueColor: AlwaysStoppedAnimation<Color>(theme.blue),
    );

    final leading = SizedBox(
      height: 42,
      width: 42,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ImageWidgetCached(
          dappInfo.images?.logo! ?? "",
          fit: BoxFit.fill,
          height: 42,
          width: 42,
        ),
      ),
    );
    final title = Text(
      dappInfo.name!,
      style: theme.titleTextStyle,
    );
    final subtitle = Text(
      "${dappInfo.developer?.legalName ?? ""} · ${dappInfo.category}",
      style: theme.bodyTextStyle,
    );
    final listWithoutTrailing = SizedBox(
      height: 42,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
      ),
    );
    return BlocBuilder<IPackageManager, PackageManagerState>(
      bloc: getIt<IPackageManager>(),
      builder: (context, state) {
        final package = state.packageMapping![dappInfo.packageId];
        if ((dappInfo.availableOnPlatform?.contains("web") ?? false) &&
            !(dappInfo.availableOnPlatform?.contains("android") ?? false)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 23.0),
                child: listWithoutTrailing,
              ),
              AppButton(
                key: Key(dappInfo.dappId!),
                height: 32,
                width: MediaQuery.of(context).size.width * 0.456,
                showPrimary: true,
                showSecondary: true,
                radius: 4,
                dappInfo: dappInfo,
                theme: theme,
              ),
            ],
          );
        }
        if (((package?.status == DownloadTaskStatus.enqueued) ||
                (package?.status == DownloadTaskStatus.running) ||
                (package?.progress != 100 && package?.progress != null)) &&
            !(package?.status == DownloadTaskStatus.failed ||
                package?.status == DownloadTaskStatus.undefined)) {
          return SizedBox(
            height: 42,
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: circularProgressIndicator,
            ),
          );
        }
        if ((package?.installing ?? false)) {
          return SizedBox(
            height: 42,
            child: ListTile(
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: installingButton,
            ),
          );
        }
        if (dappInfo.availableOnPlatform?.contains("android") ?? false) {
          if (!(state.packageMapping![dappInfo.packageId]?.installed ??
              false)) {
            return SizedBox(
              height: 42,
              child: ListTile(
                leading: leading,
                title: title,
                subtitle: subtitle,
                trailing: installButton,
              ),
            );
          } else {
            var installedVersion = Version.parse("0.0.0");

            var availableVersion = Version.parse("0.0.0");

            try {
              installedVersion = Version.parse(package?.versionName ?? "0.0.0");
              availableVersion = Version.parse(
                  dappInfo.version?.replaceAll("v", "") ?? "0.0.0");
            } catch (_) {}

            if (installedVersion < availableVersion) {
              return Column(
                children: [
                  listWithoutTrailing,
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: AppButton(
                      key: Key(dappInfo.dappId!),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.45,
                      showPrimary: true,
                      showSecondary: true,
                      radius: 4,
                      dappInfo: dappInfo,
                      theme: theme,
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox(
                height: 42,
                child: ListTile(
                  leading: leading,
                  title: title,
                  subtitle: subtitle,
                  trailing: openButton,
                ),
              );
            }
          }
        }
        return listWithoutTrailing;
      },
    );
  }
}
