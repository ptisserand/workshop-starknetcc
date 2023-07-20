.PHONY: build clean setup

####
CONTRACT_SOURCE=
CONTRACT_NAME=
####

current_dir=$(shell pwd)
TOP_DIR=$(shell dirname $(current_dir))

SRC_DIR=$(current_dir)/src
TGT_DIR=$(current_dir)/target/dev

SRC=$(SRC_DIR)/lib.cairo
SIERRA=$(TGT_DIR)/$(CONTRACT_NAME).sierra.json
CASM=$(TGT_DIR)/$(CONTRACT_NAME).casm.json


$(CASM) $(SIERRA): $(SRC)
	scarb build

build: $(CASM) $(SIERRA)

clean:
	scarb clean

setup:
	dart $(TOP_DIR)/tool/bin/setup_contracts.dart --sierra $(SIERRA) --casm $(CASM)
