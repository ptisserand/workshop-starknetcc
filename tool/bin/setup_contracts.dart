import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:starknet/starknet.dart';

void main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Show usage information')
    ..addOption(
      'sierra',
      help: 'Input path to sierra file',
      mandatory: true,
    )
    ..addOption(
      'casm',
      help: 'Input path to casm file',
      mandatory: true,
    )
    ..addOption(
      'output',
      help: 'Output path to JSON containing contract information',
      mandatory: true,
    )
    ..addFlag('no-declare', negatable: false, help: 'No declare')
    ..addFlag('no-deploy', negatable: false, help: 'No deploy');

  final results = parser.parse(args);
  if (results['help']) {
    print('Usage: dart ${Platform.script.path} ${_generateOptions(parser)}');
    print(parser.usage);
    return;
  }

  final sierraPath = results['sierra'];
  final casmPath = results['casm'];
  final outputPath = results['output'];
  final account = account0; // devnet first account
  final sierraContract = await CompiledContract.fromPath(sierraPath);
  final casmContract = await CASMCompiledContract.fromPath(casmPath);

  Felt sierraClassHash = Felt(sierraContract.classHash());
  BigInt casmClassHash = casmContract.classHash();

  print(
    "$sierraPath : ${sierraClassHash.toHexString()}",
  );
  print(
    "$casmPath: ${Felt(casmClassHash).toHexString()}",
  );

  if (results['no-declare'] != true) {
    Felt txHash = Felt.fromInt(0);
    final declareTx = await account.declare(
      compiledContract: sierraContract,
      compiledClassHash: casmClassHash,
    );
    declareTx.when(
      result: (result) {
        sierraClassHash = result.classHash;
        txHash = result.transactionHash;
        print(
          "Contract ClassHash: ${sierraClassHash.toHexString()} (${txHash.toHexString()})",
        );
      },
      error: (error) {
        throw Exception(
          "Failed to declare contract: ${error.code}: ${error.message}",
        );
      },
    );

    bool txStatus = await waitForAcceptance(
      transactionHash: txHash.toHexString(),
      provider: account.provider,
    );
    if (!txStatus) {
      final tx = await account.provider.getTransactionByHash(txHash);
      print("Contract declare transaction failed");
      prettyPrintJson(tx.toJson());
      throw Exception("Declare transaction failed");
    } else {
      final txReceipt = await account.provider.getTransactionReceipt(txHash);
      print("Contract declare transaction OK!");
      prettyPrintJson(txReceipt.toJson());
    }
  }

  if (results['no-deploy'] != true) {
    final contractAddress = await account.deploy(classHash: sierraClassHash);
    print("### CONTRACT IS DEPLOYED AT ${contractAddress!.toHexString()}");
    final String output = jsonEncode({
      'address': contractAddress.toHexString(),
      'class_hash': sierraClassHash.toHexString(),
      'deployer': account.accountAddress.toHexString(),
    });
    await File(outputPath).writeAsString(output);
  }
}

String _generateOptions(ArgParser parser) {
  final buffer = StringBuffer();
  for (var option in parser.options.keys) {
    if (parser.options[option]!.isSingle) {
      buffer.write('[--$option value] ');
    } else {
      buffer.write('[--$option] ');
    }
  }
  return buffer.toString().trim();
}
