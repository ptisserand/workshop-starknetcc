# Using low level starknet.dart API

In this step, you will setup a basic starknet.dart application using the `Contract` class.

To ease usage of devnet, starknet.dart provide the `account0` object which represent the first [predeployed account of devnet.](https://0xspaceshard.github.io/starknet-devnet/docs/guide/accounts#predeployed-accounts)

### Create application directory
Create a new dart cli application name dart
```shell
dart create app
```

### pubspec overrides
Create a file named `pubspec_overrides.yaml` in your `app` directory with the following content:
```yaml
dependency_overrides:
  starknet:
      git:
        url: https://github.com/focustree/starknet.dart
        path: packages/starknet
  starknet_builder:
      git:
        url: https://github.com/focustree/starknet.dart
        path: packages/starknet_builder
```

Since starknet.dart is not yet released, you will use the latest version on github.

### Replace main
Replace the `app/bin/app.dart` which the following content
```dart
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
```

We need to implement `getCounter` and `increaseCounter` in our `app/lib/app.dart`

### Template content of `app/lib/app.dart`
```dart
Future<int> getCounter(String contractAddress) async {
    return 0;
}

Future<bool> increaseCounter(String contractAddress) async {
    return true;
}
```

### Update pubspec
Add `starknet` in your `app/pubspec.yaml` dependencies:
```yaml
name: app
description: A sample command-line application.
version: 1.0.0
# repository: https://github.com/my_org/my_repo

environment:
  sdk: ^3.0.5

# Add regular dependencies here.
dependencies:
  # path: ^1.8.0
  starknet:
  
dev_dependencies:
  lints: ^2.0.0
  test: ^1.21.0
```

And then run
```shell
dart pub get
```

### Running your app
The main is expected a JSON file containing deployment information as first argument

```shell
dart run ./app/bin/app.dart ./contracts/deployment.json
```
