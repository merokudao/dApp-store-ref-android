import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';

class ConnectedAccount {
  final List<ChainMetadata> chains;
  final String address;
  const ConnectedAccount({
    required this.chains,
    required this.address,
  });
}
