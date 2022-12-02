import 'dart:io';

import 'package:flutter_web3_basic/models/models.dart';

class DeeplinkUtil {
  static const wcBridge = 'wc?uri=';

  static String getDeeplink({
    required CryptoWallet wallet,
    required String uri,
  }) {
    if (Platform.isIOS) {
      return wallet.universalLink + wcBridge + Uri.encodeComponent(uri);
    } else {
      return uri;
    }
  }
}