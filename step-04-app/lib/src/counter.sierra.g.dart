// Generated code, do not modify. Run `build_runner build` to re-generate!

import 'package:starknet/starknet.dart';

class Counter {
  Counter({
    required account,
    required address,
  }) : _contract = Contract(
          account: account,
          address: address,
        );

  final Contract _contract;

  Future<String> constructor() async {
    final List<Felt> params = [];
    final trx = await _contract.execute(
      'constructor',
      params,
    );
    final trxHash = trx.when(
      result: (result) => result.transaction_hash,
      error: (error) => throw Exception,
    );
    return trxHash;
  }

  Future<Felt> get_counter() async {
    final List<Felt> params = [];
    final res = await _contract.call(
      'get_counter',
      params,
    );
    return Felt.fromCallData(res);
  }

  Future<String> tick() async {
    final List<Felt> params = [];
    final trx = await _contract.execute(
      'tick',
      params,
    );
    final trxHash = trx.when(
      result: (result) => result.transaction_hash,
      error: (error) => throw Exception,
    );
    return trxHash;
  }

  Future<String> reset_counter() async {
    final List<Felt> params = [];
    final trx = await _contract.execute(
      'reset_counter',
      params,
    );
    final trxHash = trx.when(
      result: (result) => result.transaction_hash,
      error: (error) => throw Exception,
    );
    return trxHash;
  }
}
