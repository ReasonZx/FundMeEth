// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {

    FundMe fundMe;
    address USER = makeAddr("user");    //create a fake address in virtual chain

    function setUp() external {
        vm.deal(USER, 10 ether);        //send 10 eth to fake address
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    modifier funded() {
        vm.startPrank(USER);                 //next transaction on virtual chain will be from fake address
        fundMe.fund{value: 1 ether}();
        vm.stopPrank(); 
        _;
    }

    function testFunderArray() public funded {
        assertEq(fundMe.funders(0), USER);
    }

    function testWithdrawFromMultipleFunders() public funded {

        for(uint160 index = 1; index < 10; index++) {
            hoax(address(index), 0.1 ether);        //hoax = deal+prank
            fundMe.fund{value: 0.1 ether}();
        }

        uint256 startingOwnerValue = fundMe.i_owner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.startPrank(fundMe.i_owner());
        fundMe.withdraw();
        vm.stopPrank(); 

        assert(address(fundMe).balance == 0);
        assert(startingOwnerValue + startingFundMeBalance == fundMe.i_owner().balance);

    }
}
