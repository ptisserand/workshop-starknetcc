#!/bin/bash

ENV_NAME=$(poetry env list)
echo "Poetry environment: ${ENV_NAME}"

echo "Updating permissions for starknet compilers v1"
chmod 755 ${HOME}/.cache/pypoetry/virtualenvs/${ENV_NAME}/lib/python3*/site-packages/starkware/starknet/compiler/v1/bin/starknet-*
