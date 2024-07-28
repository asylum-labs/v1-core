# TODO

## Modularize Codebase

Move the testnet utils into xeon-testnet repo, and make that one public
`v1-core` should be exclusively core contracts

## ABI workflow

Remove `SaveABI.s.sol` and replace with a github workflow that:

- on push, do the following:

1. run cast command to obtain the ABI files from onchain
2. save output files to `abi/` directory

```sh
"cast abi --out abi/", contractName, ".abi.json ", contractAddress
```

**NOTE:** may need to add RPCs to repo env variables

## Hardcoded Address variables

store these in a local file like `onchainData.json` and import into script files to populate with deployment addresses
