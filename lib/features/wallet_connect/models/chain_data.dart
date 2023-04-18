import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:flutter/material.dart';

class ChainData {
  static final List<ChainMetadata> mainChains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:1',
      name: 'Ethereum',
      logo: '/chain-logos/eip155-1.png',
      color: Colors.blue.shade300,
      rpc: ['https://cloudflare-eth.com/'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:137',
      name: 'Polygon',
      logo: '/chain-logos/eip155-137.png',
      color: Colors.purple.shade300,
      rpc: ['https://polygon-rpc.com/'],
    ),
  ];

  static final List<ChainMetadata> testChains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:5',
      name: 'Ethereum Goerli',
      logo: '/chain-logos/eip155-1.png',
      color: Colors.blue.shade300,
      isTestnet: true,
      rpc: ['https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:80001',
      name: 'Polygon Mumbai',
      logo: '/chain-logos/eip155-137.png',
      color: Colors.purple.shade300,
      isTestnet: true,
      rpc: ['https://matic-mumbai.chainstacklabs.com'],
    ),
  ];

  static final List<ChainMetadata> allChains = [...mainChains, ...testChains];
}
