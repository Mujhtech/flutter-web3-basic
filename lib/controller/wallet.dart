// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:eip55/eip55.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:flutter_web3_basic/blockcain/forumV1.g.dart';
import 'package:flutter_web3_basic/constant.dart';
import 'package:flutter_web3_basic/main.dart';
import 'package:flutter_web3_basic/models/forum.dart';
import 'package:flutter_web3_basic/models/models.dart';
import 'package:flutter_web3_basic/utils/utils.dart';

class WalletController extends ChangeNotifier {
  bool balRefresh = false;
  int bottomNavbarIndex = 0;
  List? _forums;
  List? get forums => _forums;

  EtherAmount bal = EtherAmount.fromUnitAndValue(EtherUnit.wei, 0);

  final WalletConnectHelper walletConnectHelper = WalletConnectHelper(
    bridge: GlobalConstants.bridge,
    appInfo: AppInfo(
      name: GlobalConstants.name,
      description: GlobalConstants.name,
      url: GlobalConstants.url,
    ),
  );

  late Web3Client web3client;
  //late StreamChicken2Contract contract;

  bool isConnectWallet = false;
  String? publicWalletAddress;

  void connectWallet(context) async {
    isConnectWallet = await walletConnectHelper.initSession(context,
        chainId: GlobalConstants.testnetChainId);
    if (isConnectWallet) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'Devfest Minna 2022',
                  )));
      publicWalletAddress = walletConnectHelper
          .getEthereumCredentials()
          .getEthereumAddress()
          .toString();
      publicWalletAddress = toEIP55Address(publicWalletAddress!);

      // Init web3client
      initWeb3Client();

      // get Balance
      await getBalance();

      // Init contract
      await fetchComment();

      // Update ui
      notifyListeners();
    }
  }

  void updateBottomNavbarIndex(int value) {
    bottomNavbarIndex = value;
    notifyListeners();
  }

  // Disconnet wallet
  void disconnectWallet() {
    walletConnectHelper.dispose();
    isConnectWallet = false;
    publicWalletAddress = null;
    bottomNavbarIndex = 0;
    notifyListeners();
  }

  void initWeb3Client() {
    web3client = Web3Client(GlobalConstants.testnetApiUrl, Client());
  }

  Future getBalance() async {
    var address =
        await walletConnectHelper.getEthereumCredentials().extractAddress();
    bal = await web3client.getBalance(address);
    notifyListeners();
  }

  Future<void> fetchComment() async {
    try {
      final forumV1 = ForumV1(
        address: EthereumAddress.fromHex(GlobalConstants.contractAddress),
        client: web3client,
      );
      final res = await forumV1.getComments('Devfest Minna 2022');
      _forums = Forum.fromMaps(res);
      notifyListeners();
    } catch (e) {
      //
    }
  }

  Future<void> addComment(String message) async {
    try {
      final forumV1 = ForumV1(
        address: EthereumAddress.fromHex(GlobalConstants.contractAddress),
        client: web3client,
      );
      Credentials cred = walletConnectHelper.getEthereumCredentials();
      await forumV1.addComment('Devfest Minna 2022', message,
          credentials: cred,
          transaction: Transaction(
              from: walletConnectHelper
                  .getEthereumCredentials()
                  .getEthereumAddress()));
      await fetchComment();
    } catch (e) {
      //
      print(e);
    }
  }
}
