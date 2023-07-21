import 'dart:convert';
import 'dart:io';
import 'package:app/app.dart' as app;

void main(List<String> arguments) async {
  final deploymentPath = arguments[0];
  final Map<String, Object?> deployment =
      jsonDecode((await File(deploymentPath).readAsString()));
  final contractAddress = deployment["address"] as String;

  print('Counter: ${(await app.getCounter(contractAddress))}');
  print('Increasing counter');
  final ok = await app.increaseCounter(contractAddress);
  print('Transaction succeeded: $ok');
  print('Counter: ${(await app.getCounter(contractAddress))}');
}
