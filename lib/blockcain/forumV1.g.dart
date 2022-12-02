// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"string","name":"topic","type":"string"},{"internalType":"string","name":"message","type":"string"}],"name":"addComment","outputs":[],"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"components":[{"internalType":"uint32","name":"id","type":"uint32"},{"internalType":"string","name":"topic","type":"string"},{"internalType":"address","name":"creator_address","type":"address"},{"internalType":"string","name":"message","type":"string"},{"internalType":"uint256","name":"created_at","type":"uint256"}],"indexed":false,"internalType":"struct ForumV1.Comment","name":"comment","type":"tuple"}],"name":"CommentAdded","type":"event"},{"inputs":[{"internalType":"string","name":"topic","type":"string"}],"name":"getComments","outputs":[{"components":[{"internalType":"uint32","name":"id","type":"uint32"},{"internalType":"string","name":"topic","type":"string"},{"internalType":"address","name":"creator_address","type":"address"},{"internalType":"string","name":"message","type":"string"},{"internalType":"uint256","name":"created_at","type":"uint256"}],"internalType":"struct ForumV1.Comment[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"}]',
  'ForumV1',
);

class ForumV1 extends _i1.GeneratedContract {
  ForumV1({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addComment(
    String topic,
    String message, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'ae5ff905'));
    final params = [
      topic,
      message,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getComments(
    String topic, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '70c63fcc'));
    final params = [topic];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// Returns a live stream of all CommentAdded events emitted by this contract.
  Stream<CommentAdded> commentAddedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('CommentAdded');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return CommentAdded(decoded);
    });
  }
}

class CommentAdded {
  CommentAdded(List<dynamic> response) : comment = (response[0] as dynamic);

  final dynamic comment;
}
