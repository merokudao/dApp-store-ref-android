import 'package:wallet_connect_dart_v2/core/models/app_metadata.dart';

class Config {
  const Config._();
  static const registryApiBaseUrl = "https://api-a.meroku.store";
  static const customApiBaseUrl = "https://htc.guardiannft.net";
  static const sentryDSN =
      "https://6b758247cdb149a1950fd476f793df98@o4504921352372224.ingest.sentry.io/4504921353486336";
}

class WalletConnectConfig {
  const WalletConnectConfig._();
  static const projectId = "36f352c5daeb6ed6ae15657366a9df3d";
  static const relayUrl = "wss://relay.walletconnect.com";
  static const metadata = AppMetadata(
    name: 'Slick Store',
    description: 'dAppStore by Slick Team',
    url: 'https://slickwallet.xyz/',
    icons: ['https://avatars.githubusercontent.com/u/82613752?s=200&v=4'],
  );
  static const database = 'memory';

  static const signMessageData = "I allow to connect my wallet to Slick Store";
  static const connectingChain = ["eip155:137", "eip155:1"];
}
