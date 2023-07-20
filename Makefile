.PHONY: devnet contracts

contracts:
	make -C ./contracts

devnet:
	make -C ./devnet

fixup:
	make -C ./devnet fixup
