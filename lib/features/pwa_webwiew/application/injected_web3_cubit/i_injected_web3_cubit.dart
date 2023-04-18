import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';

import 'injected_web3_cubit.dart';

abstract class IInjectedWeb3Cubit extends Cubit<InjectedWeb3State> {
  IInjectedWeb3Cubit(super.initialState);

  started();

  connect(int chainId, String originalUrl);

  changeChains(int chainId);

  String? get account;

  String? get chainId;

  Future<String> sendTransaction(
    JsTransactionObject jsTransactionObject,
  );

  Future<String> signTransaction(
    JsTransactionObject jsTransactionObject,
  );

  Future<String> ecRecover(
    JsEcRecoverObject ecRecoverObject,
  );

  Future<String> signPersonalMessage(
    String data,
  );

  Future<String> signMessage(
    String data,
  );

  Future<String> signTypedData(
    JsEthSignTypedData data,
  );
}
