import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_web3_basic/constant.dart';
import 'package:flutter_web3_basic/models/models.dart';
import 'package:flutter_web3_basic/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

/// WalletConnectHelper is an object for implement WalletConnect protocol for
/// mobile apps using deep linking to connect with wallets.
class WalletConnectHelper {
  final String? bridge;

  /// mobile app info
  final AppInfo appInfo;

  late WalletConnect connector;

  SessionStatus? sessionStatus;
  List<String> accounts = [];

  /// Connector using brigde 'https://bridge.walletconnect.org' by default.
  WalletConnectHelper({
    this.bridge,
    required this.appInfo,
  }) {
    connector = getWalletConnect();
  }

  WalletConnect getWalletConnect() {
    final WalletConnect connector = WalletConnect(
      bridge: bridge ?? 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: appInfo.name ?? 'Devfest Minna 2022',
        description: appInfo.description ?? 'Devfest Minna 2022 - GDG Minna',
        url: appInfo.url ?? 'https://walletconnect.org',
        icons: appInfo.icons ??
            ['https://cryptologos.cc/logos/polygon-matic-logo.png'],
      ),
    );
    return connector;
  }

  //----------------------------------------------------------------

  void reset() {
    connector = getWalletConnect();
  }

  Future<bool> initSession(context, {int? chainId}) async {
    try {
      return await initMobileSession(chainId: chainId);
    } catch (e) {
      return false;
    }
  }

  Future<bool> initMobileSession({int? chainId}) async {
    if (!connector.connected) {
      try {
        sessionStatus = await connector.createSession(
          chainId: chainId,
          onDisplayUri: (uri) async {
            await _connectWallet(displayUri: uri);
          },
        );

        accounts = sessionStatus?.accounts ?? [];

        return true;
      } catch (e) {
        debugPrint('createSession() - failure - $e');
        reset();
        return false;
      }
    } else {
      return true;
    }
  }

  Future<void> _connectWallet({
    CryptoWallet wallet = CryptoWallet.metamask,
    required String displayUri,
  }) async {
    var deeplink = DeeplinkUtil.getDeeplink(wallet: wallet, uri: displayUri);
    bool isLaunch = await launchUrl(Uri.parse(deeplink),
        mode: LaunchMode.externalApplication);
    if (!isLaunch) {
      throw 'connectWallet() - failure - Could not open $deeplink.';
    }
  }

  WalletConnectEthereumCredentials getEthereumCredentials() {
    EthereumWalletConnectProvider provider = EthereumWalletConnectProvider(
        connector,
        chainId: GlobalConstants.testnetChainId);

    WalletConnectEthereumCredentials credentials =
        WalletConnectEthereumCredentials(provider: provider);

    return credentials;
  }

  Future<void> dispose() async {
    connector.session.reset();
    await connector.killSession();
    await connector.close();

    sessionStatus = null;
    accounts = [];

    reset();
  }
}
