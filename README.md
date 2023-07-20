# Starknet.dart

## Step 03: using source code generator

- Add `starknet_builder` and `build_runner` to your application [`pubspec.yaml`](./app/pubspec.yaml) in `dev_dependencies`
```yaml
dev_dependencies:
  lints: ^2.0.0
  test: ^1.21.0
  starknet_builder:
  build_runner: ^2.1.11
```
- Create a `lib/src` directory in your app.
```shell
mkdir app/lib/src
```
- Extract JSON ABI from your sierra compiled contract to your app source code.
```shell
dart run ./tool/bin/extract_sierra_json.dart --input ./contracts/target/dev/contracts_Counter.sierra.json --output ./app/lib/src/counter.sierra.json
```
- Run build_runner in `app` directory:
```shell
dart run build_runner build
```
- It will generate a file named `counter.sierra.g.dart` in `app/lib/src` directory:
```
$ ls -1  app/lib/src/
counter.sierra.g.dart
counter.sierra.json
```
- Now you can import this file into your `app/lib/app.dart`, and then easily call the contract:
```
await contract.get_counter()
```
```
final txHash = await contract.tick();
```
## Start devnet with deployed contract

Start devnet in a terminal
```shell
make devnet
```

Fix cairo-lang issue if any
```shell
make fixup
```

Build, declare and deploy contract on devnet
```shell
make setup
```

## Dependencies

- [scarb](https://docs.swmansion.com/scarb)
- [starkli](https://book.starkli.rs/)
- [poetry](https://python-poetry.org/)
  
### Version management:
Scarb version is managed with [asdf](https://asdf-vm.com/guide/getting-started.html)
Python is managed with [pyenv](https://github.com/pyenv/pyenv)

## Directories

### app

Contains `pubspec_overrides.yaml` to force `starknet` and `starknet_builder` coming from github.

### contracts

Contains source code for Cairo contract

### devnet

Contains setup to run a local devnet.

To start devnet:
```shell
$ make devnet
```

If you have an issue when declaring a contract, it could be related to permission of starknet compiler in cairo-lang package.

You can run the following command to fix it:
```shell
make fixup
```

The path to directory containing starknet compilers when using poetry should be:
`${HOME}/.cache/pypoetry/virtualenvs/${env_name}/lib/${python_version}/site-packages/starkware/starknet/compiler/v1/bin`

### tool

Contains a dart script to extract ABI part from a Sierra json file.

Usage:
```
$ dart pub get
$ dart run ./bin/extract_sierra_json.dart --input SIERRA.json --output ABI.json
```
