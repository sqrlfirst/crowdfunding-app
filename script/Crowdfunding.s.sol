// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Crowdfunding} from "../src/Crowdfunding.sol";

contract DeployCrowdfunding is Script {
    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        uint256 goal = vm.envUint("GOAL");
        uint256 deadline = vm.envUint("DEADLINE");

        // Start broadcasting for deployment
        vm.startBroadcast(deployerPrivateKey);

        Crowdfunding crowdfunding = new Crowdfunding(goal, deadline);

        vm.stopBroadcast();

        console.log("Crowdfunding was deployed at: ", address(crowdfunding));
    }
}
