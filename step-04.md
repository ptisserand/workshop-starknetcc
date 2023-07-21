# Using low level starknet.dart API

In this step, you will adapt flutter demo counter to use your smart contract.

To ease usage of devnet, starknet.dart provide the `account0` object which represent the first [predeployed account of devnet.](https://0xspaceshard.github.io/starknet-devnet/docs/guide/accounts#predeployed-accounts)

### Create application directory
Create a new flutter application
```shell
flutter create app
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


### Update pubspec
Add `starknet` in `dependencies`, `starknet_builder` and `build_runner` in `build_dependcies` in your `app/pubspec.yaml` 

And then run
```shell
flutter pub get
```

### Running your app
With flutter, you can't specify any arguments to main, so you need to use environment
```shell
flutter run -d linux --dart-define-from-file=../contracts/deployment.json 
```

To retrieve contract address value in your code:
```dart
const contractAddress = String.fromEnvironment("address");
```

### Generate source code from sierra JSON file
To generate source code from a sierra JSON file, the first step is to extract the ABI from this file.
```shell
mkdir app/lib/src
```
```shell
dart run ./tool/bin/extract_sierra_json.dart --input ./contracts/target/dev/contracts_Counter.sierra.json --output ./app/lib/src/counter.sierra.json
```

You can now execute `build_runner` to generate a file named `counter.sierra.g.dart`
```shell
cd app
dart run build_runner build
```