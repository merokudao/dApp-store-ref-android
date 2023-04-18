import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter/material.dart';

abstract class IInstalledDappsTileHandler {
  IPackageManager get packageManager;
  IStoreCubit get storeCubit;
  IWalletConnectCubit get walletConnectCubit;
  updateDapp(DappInfo dappInfo);
  openDapp(BuildContext context, String dappId);
}
