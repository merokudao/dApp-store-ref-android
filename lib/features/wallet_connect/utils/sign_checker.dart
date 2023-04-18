import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/foundation.dart';

class SigChecker {
  SigChecker._();

  /// ecRecover workaround to check addresses
  static bool checkSignature(
      {required String unhexedMessage,
      required String signature,
      required String? activeAddress}) {
    final messageBytes = Uint8List.fromList(unhexedMessage.codeUnits);

    final recoveredAddress = EthSigUtil.recoverPersonalSignature(
        signature: signature, message: messageBytes);
    return activeAddress?.toLowerCase() == recoveredAddress.toLowerCase();
  }
}
