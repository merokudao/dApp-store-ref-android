import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';

abstract class ISigner {
  ISigner() : super();

  getPersonalSign(
    String data,
  );

  getEthSign(String data);

  getEthSignTypedData(String data);

  getEthSignTransaction(EthereumTransaction transaction, int chainId);

  getEthSendTransaction(EthereumTransaction transaction, int chainId);
}
