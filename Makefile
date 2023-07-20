.PHONY: devnet contracts setup fixup

contracts:
	make -C ./contracts

setup: contracts
	make -C ./contracts setup

devnet:
	make -C ./devnet

fixup:
	make -C ./devnet fixup
