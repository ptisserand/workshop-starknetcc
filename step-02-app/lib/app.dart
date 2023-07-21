import 'package:starknet/starknet.dart';

final account = account0;
final provider = account0.provider;

Future<int> getCounter(String contractAddress) async {
  final contract = Contract(
    account: account0,
    address: Felt.fromHexString(contractAddress),
  );
  final result = await contract.call("get_counter", []);
  return result[0].toInt();
}

Future<bool> increaseCounter(String contractAddress) async {
  final contract = Contract(
    account: account0,
    address: Felt.fromHexString(contractAddress),
  );
  final response = await contract.execute("tick", []);

  final txHash = response.when(
    result: (result) => result.transaction_hash,
    error: (err) => throw Exception("Failed to execute"),
  );
  return waitForAcceptance(transactionHash: txHash, provider: provider);
}
