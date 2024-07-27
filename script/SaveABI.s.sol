// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {console2} from "forge-std/console2.sol";

abstract contract SaveABI {
    /**
     * @dev print output to console to save ABI of deployed contract
     * @dev the resulting ABI can be synced with `xeon-dapp/abi/`
     * @param contractAddress address of the deployed contract
     * @param contractName name of the contract
     */
    function saveAbi(address contractAddress, string memory contractName) internal virtual {
        string memory command = string(
            abi.encodePacked(
                "cast abi --out abi/", contractName, ".abi.json ", contractAddress
            )
        );
        exec(command);
    }

    function exec(string memory command) internal pure {
        console2.log("Run the following command to save ABI:", command);
    }
}
