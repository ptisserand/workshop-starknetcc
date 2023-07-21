import 'package:starknet/starknet.dart';
import 'src/counter.sierra.g.dart';

final account = account0;
final provider = account0.provider;

Future<int> getCounter(String contractAddress) async {
  final contract =
      Counter(account: account, address: Felt.fromHexString(contractAddress));
  return (await contract.get_counter()).toInt();
}

Future<bool> increaseCounter(String contractAddress) async {
  final contract =
      Counter(account: account, address: Felt.fromHexString(contractAddress));
  final txHash = await contract.tick();
  return waitForAcceptance(transactionHash: txHash, provider: provider);
}
