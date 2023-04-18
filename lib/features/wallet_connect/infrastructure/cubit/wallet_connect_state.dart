part of 'wallet_connect_cubit.dart';

@freezed
class WalletConnectState with _$WalletConnectState {
  const factory WalletConnectState({
    required bool connected,
    required bool loadingConnection,
    required bool failureConnection,
    required bool signVerified,
    required bool loadingSign,
    required bool failureSign,
    required bool txLoading,
    required bool txSucesess,
    required bool txFailure,
    required bool failure,
    required List<SessionStruct> sessions,
    required SessionStruct? activeSession,
    required String? activeAddress,
    required String? activeChainId,
    required List<PairingStruct> pairings,
    required List<int> approvedChains,
  }) = _WalletConnectState;

  factory WalletConnectState.initial() => const WalletConnectState(
        connected: false,
        failure: false,
        sessions: [],
        pairings: [],
        activeSession: null,
        activeAddress: null,
        activeChainId: null,
        approvedChains: [],
        signVerified: false,
        loadingConnection: false,
        failureConnection: false,
        loadingSign: false,
        failureSign: false,
        txLoading: false,
        txFailure: false,
        txSucesess: false,
      );

  factory WalletConnectState.fromJson(Map<String, dynamic> json) =>
      _$WalletConnectStateFromJson(json);
}
