# Template for starknet.dart workshop

## Dependencies

- scarb
- poetry
- starkli
  
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
Due to an issue in python packaging, you have to run the following commands to fix permission issues:

```
$ chmod 755 /home/robin/.cache/pypoetry/virtualenvs/scripts-oQrIUXm6-py3.9/lib/python3.9/site-packages/starkware/starknet/compiler/v1/bin/starknet-*
```

To start devnet:
```
$ make
```

### tool

Contains a dart script to extract ABI part from a Sierra json file.

Usage:
```
$ dart pub get
$ dart run ./bin/extract_sierra_json.dart --input SIERRA.json --output ABI.json
```
