// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Script} from "@forge-std/Script.sol";
import {console2} from "@forge-std/console2.sol";
import {XeonToken} from "../src/XeonToken.sol";
import {XeonStaking} from "../src/XeonStaking.sol";
import {XeonHedging} from "../src/XeonHedging.sol";

/* ============ Parse ABIs ============ */
// forge build --silent && jq '.abi' ./out/XeonHedging.sol/XeonHedging.abi.json
// forge build --silent && jq '.abi' ./abi/XeonStaking.abi.json
// forge build --silent && jq '.abi' ./abi/XeonToken.abi.json

/* ============ Base Sepolia ============ */
// simulate: forge script script/XeonProtocol.s.sol:XeonProtocolScript --rpc-url $BASE_SEPOLIA_RPC_URL --chain-id 84532 -vvvv
// broadcast: forge script script/Onboarding.s.sol:XeonProtocolScript --rpc-url $BASE_SEPOLIA_RPC_URL --chain-id 84532 -vv --broadcast --verify

/* ============ Ethereum ============ */
// simulate: forge script script/XeonProtocol.s.sol:XeonProtocolScript --rpc-url $ETHEREUM_RPC_URL --chain-id 1 -vvvv
// broadcast: forge script script/Onboarding.s.sol:XeonProtocolScript --rpc-url $ETHEREUM_RPC_URL --chain-id 1 -vv --broadcast --verify

contract XeonProtocolScript is Script {
    // ensure `PriceOracle.sol` is deployed on required chain
    // uncomment addresses for that chain

    /* ============ Base Sepolia ============ */
    address public priceOracle = 0x0000000000000000000000000000000000000000;
    address public uniV2Factory = 0x0000000000000000000000000000000000000000;
    address public uniV3Factory = 0x0000000000000000000000000000000000000000;

    /* ============ Ethereum Mainnet ============ */
    // address public priceOracle = 0x0000000000000000000000000000000000000000;
    // address public uniV2Factory = 0x0000000000000000000000000000000000000000;
    // address public uniV3Factory = 0x0000000000000000000000000000000000000000;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        // deploy XeonToken
        console2.log("Deploying XeonToken contract...");
        XeonToken xeonToken = new XeonToken();
        console2.log("XeonToken contract deployed at:", address(xeonToken));
        printABI(address(xeonToken), "XeonToken");

        // deploy  XeonStaking
        console2.log("Deploying XeonStaking contract...");
        XeonStaking xeonStaking = new XeonStaking(address(xeonToken));
        console2.log("XeonStaking contract deployed at:", address(xeonStaking));
        printABI(address(xeonStaking), "XeonStaking");

        // deploy XeonHedging
        console2.log("Deploying XeonHedging contract...");
        XeonHedging xeonHedging = new XeonHedging(uniV2Factory, uniV3Factory, address(priceOracle), xeonStaking);
        console2.log("XeonHedging contract deployed at:", address(xeonHedging));
        printABI(address(xeonHedging), "XeonHedging");

        vm.stopBroadcast();
    }

    /** 
     * @dev obtain the abi file for a given contract after deploying
     * !test: verify this works as intended with a hardcoded address of known ABI
     * 
     * @param contractAddress address of the contract being deployed
     * @param contractName name of the contract being deployed
     */
    function printABI(address contractAddress, string memory contractName) internal pure {
            console2.log(contractName);
            // console2.log(abi.encodePacked(contractAddress));
    }
}
