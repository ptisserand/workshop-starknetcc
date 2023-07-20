.PHONY: setup run fixup

run: .done
	poetry run starknet-devnet --seed 0 --host 0.0.0.0

.done:
	poetry install
	touch .done

setup: .done

fixup:
	./fixup.bash


