// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/BeeBox.sol";


contract TestBeeBox is Test {
    BeeBox public beebox;

    function setUp() public {
        // address addr1 = vm.addr(1);
        // vm.deal(addr1, 5 ether);
        // vm.prank(addr1);
        beebox = new BeeBox();
        // console.log("owner: %s", msg.sender);
        // console.log("address: %s", addr1);
    }

    function test_deploy() public {
        bool status = beebox.Invest(0, 100, 1);
        console.log("status: ", status);

        
    }   
}