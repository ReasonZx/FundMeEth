// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";


contract HelperConfig {


    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig.priceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        }
        else {
            //Mock
        }
    }

}