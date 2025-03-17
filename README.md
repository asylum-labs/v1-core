# v1-options-contracts

[![GitHub license](https://img.shields.io/badge/core_license-BUSL_1.1-blue.svg)](https://github.com/heyjonbray/v1-options-contracts/blob/main/LICENSE) [![GitHub license](https://img.shields.io/badge/incl_license-GPL_3.0-blue.svg)](https://github.com/heyjonbray/v1-options-contracts/blob/main/LICENSE-GPL.md)

This repository contains the core contracts for onchain execution of OTC options trading (put, call, equity swaps) including tests, and scripts. For the frontend, see the [xeon-dapp](https://github.com/heyjonbray/xeon-dapp) repository.

### Socials

[![warpcast](https://img.shields.io/badge/Follow_@jonbray.eth-FFFFFF.svg?logo=farcaster)](https://warpcast.com/jonbray.eth) ![twitter follow](https://img.shields.io/twitter/follow/heyjonbray)

### Repo Status

![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/heyjonbray/v1-options-contracts) ![GitHub commit activity](https://img.shields.io/github/commit-activity/m/heyjonbray/v1-options-contracts) ![GitHub contributors](https://img.shields.io/github/contributors/heyjonbray/v1-options-contracts)

## Prerequisites

[![git](https://img.shields.io/badge/git-any-darkgreen)](https://git-scm.com/downloads) [![npm](https://img.shields.io/badge/npm->=_6-darkgreen)](https://npmjs.com/) [![Foundry](https://img.shields.io/badge/Foundry-v0.2.0-orange)](https://book.getfoundry.sh/)

## Directory Structure

- `src` - core solidity contracts.
- `test` - tests written in solidity.
- `script` - scripts written in solidity.

## Setup

First, ensure Foundry is installed.

```shell
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

If you don't have a local version of the repository, clone it:

```shell
git clone https://github.com/heyjonbray/v1-options-contracts.git
```

Ensure you have the latest changes locally

```shell
git pull origin main
```

Install the dependency submodules using Forge:

```shell
forge install --no-commit foundry-rs/forge-std openzeppelin/openzeppelin-contracts uniswap/v2-core uniswap v3-core uniswap v3-periphery
```

The `foundry.toml` file is used to configure Foundry settings, manage RPC endpoints, and dependencies.

---

## Foundry

Foundry is a toolkit for writing smart contracts, tests, and scripts in Solidity. It is made up of the following tools:

- `forge` is used to develop, test, and deploy smart contracts.
- `cast` allows you to interact with contracts, send transactions, and get chain data from the CLI.
- `anvil` is a local node.
- `chisel` is an integrated Solidity REPL.

For more information, check out the [Foundry Book](https://book.getfoundry.sh/).

## Forge

Forge is used to build, test, and deploy smart contracts.

### Build

To build and compile all smart contracts, use:

```shell
$ forge build
```

### Test

Tests are handled through test files, written in Solidity and using the naming convention `Contract.t.sol`

```shell
$ forge test
```

### Gas Snapshots

Forge can generate gas snapshots for all test functions to see how much gas contracts will consume, or to compare gas usage before and after optimizations.

```shell
$ forge snapshot
```

### Deploy

Deployments are handled through script files, written in Solidity and using the naming convention `Contract.s.sol`

You can run a script directly from your CLI

```shell
$ forge script script/MyContract.s.sol:MyContractScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

Unless you include the `--broadcast` argument, the script will be run in a simulated environment. If you need to run the script live, use the `--broadcast` arg

⚠️ **CAUTION: Using `--broadcast` will initiate an onchain transaction, only use after thoroughly testing**

```shell
$ forge script script/MyContract.s.sol:MyContractScript --rpc-url <your_rpc_url> --private-key <your_private_key> --chain-id 1 -vv --broadcast
```

Additional arguments can specity the chain and verbosity of the script

```shell
$ forge script script/MyContract.s.sol:MyContractScript --rpc-url <your_rpc_url> --private-key <your_private_key> --chain-id 1 -vv
```

Additionally, you can pass a private key directly into script functions to prevent exposing it in the command line (recommended).

⚠️ **CAUTION: Ensure you are using a `.env.local` and a proper `.gitignore` to prevent leaked keys.**

```js
function run() public {
    vm.startBroadcast(vm.envUint('PRIVATE_KEY'));
    // rest of your code...
}
```

Then run the `forge script` command without the private key arg.

💡 **When deploying a new contract, use the `--verify` arg to verify the contract on deployment.**

## Contributing

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-darkgreen.svg)](https://github.com/heyjonbray/v1-options-contracts/blob/main/CONTRIBUTING.md) [![Bug Bounties](https://img.shields.io/badge/Bug_Bounties-open-red.svg)](https://github.com/heyjonbray/v1-options-contracts/blob/main/SECURITY.md)

If you are a contributor, please take a look at the guidelines in [CONTRIBUTING](https://github.com/heyjonbray/v1-options-contracts/blob/main/CONTRIBUTING.md) first, then find an [open issue](https://github.com/heyjonbray/v1-options-contracts/issues/) or open a [new one](https://github.com/heyjonbray/v1-options-contracts/issues/new/choose).

## Security

For any security-related concerns, please refer to the [SECURITY](https://github.com/heyjonbray/v1-options-contracts/blob/main/SECURITY.md) policy.

## License

The primary license for the core contracts (`XeonHedging.sol` + `XeonStaking.sol`) is the Business Source License 1.1 (BUSL-1.1), see [`LICENSE.md`](https://github.com/heyjonbray/v1-options-contracts/blob/main/LICENSE.md).

However, there are some exceptions:

- Several files in `contracts/script` and `contracts/test` are licensed under `GPL-3.0-or-later` (see: [`LICENSE-GPL.md`](https://github.com/heyjonbray/v1-options-contracts/blob/main/LICENSE-GPL.md)) or remain unlicensed (per their SPDX headers).
