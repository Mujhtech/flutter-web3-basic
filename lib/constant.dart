enum BlockchainFlavor {
  ropsten,
  rinkeby,
  ethMainNet,
  polygonMainNet,
  mumbai,
  unknown,
}

class GlobalConstants {
  static const String testnetApiUrl = "https://rpc-mumbai.maticvigil.com/";
  static const String mainnettApiUrl = "https://polygon-rpc.com/";
  static const String bridge = "https://bridge.walletconnect.org";
  static const String name = "Polygon";
  static const String url = "https://polygon.technology";
  static const String contractAddress =
      '0xe2876235294175a2369E44939471C3104cC6ACdD';
  static const int testnetChainId = 80001;
  static const int mainnetChainId = 137;
}

extension BlockchainFlavorExtention on BlockchainFlavor {
  static BlockchainFlavor fromChainId(int chainId) {
    switch (chainId) {
      case 80001:
        return BlockchainFlavor.mumbai;
      case 137:
        return BlockchainFlavor.polygonMainNet;
      case 3:
        return BlockchainFlavor.ropsten;
      case 4:
        return BlockchainFlavor.rinkeby;
      case 1:
        return BlockchainFlavor.ethMainNet;
      default:
        return BlockchainFlavor.unknown;
    }
  }
}
