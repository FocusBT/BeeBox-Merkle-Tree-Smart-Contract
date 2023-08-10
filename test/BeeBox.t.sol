// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/BeeBox.sol";


contract TestBeeBox is Test {
    BeeBox public beebox;

    address addr1 = vm.addr(1);
        address addr2 = vm.addr(2);
        address addr3 = vm.addr(3);
        address addr4 = vm.addr(4);
        address addr5 = vm.addr(5);
        address addr6 = vm.addr(6);
        address addr7 = vm.addr(7);
        address addr8 = vm.addr(8);
        address addr9 = vm.addr(9);
        address addr10 = vm.addr(10);
        address addr11 = vm.addr(11);

    function setUp() public {
        console.log("owner", msg.sender);
        beebox = new BeeBox();
        // console.log("owner: %s", msg.sender);
        // console.log("address: %s", addr1);
    }

    // function test_levels() public {
    //     vm.prank(addr1);
    //     beebox.Invest(0, 100, 1);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
        
    //     console.log("After 1st user joinning");

    //     vm.prank(addr2);
    //     beebox.Invest(1, 100, 2);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
        
    //     console.log("After 2nd user joinning");

    //     vm.prank(addr3);
    //     beebox.Invest(2, 100, 3);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));

    //     console.log("After 3rd user joinning");

    //     vm.prank(addr4);
    //     beebox.Invest(3, 100, 4);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));

    //     console.log("After 4th user joinning");

    //     vm.prank(addr5);
    //     beebox.Invest(4, 100, 5);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));

    //     console.log("After 5th user joinning");

    //     vm.prank(addr6);
    //     beebox.Invest(5, 100, 6);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));
    //     console.log("balance of user 6: ", beebox.UserBalanceByAddr(addr6));

    //     console.log("After 6th user joinning");

    //     vm.prank(addr7);
    //     beebox.Invest(6, 100, 7);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));
    //     console.log("balance of user 6: ", beebox.UserBalanceByAddr(addr6));
    //     console.log("balance of user 7: ", beebox.UserBalanceByAddr(addr7));

    //     console.log("After 7th user joinning");

    //     vm.prank(addr8);
    //     beebox.Invest(7, 100, 8);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));
    //     console.log("balance of user 6: ", beebox.UserBalanceByAddr(addr6));
    //     console.log("balance of user 7: ", beebox.UserBalanceByAddr(addr7));
    //     console.log("balance of user 8: ", beebox.UserBalanceByAddr(addr8));

    //     console.log("After 8th user joinning");

    //     vm.prank(addr9);
    //     beebox.Invest(8, 100, 9);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));
    //     console.log("balance of user 6: ", beebox.UserBalanceByAddr(addr6));
    //     console.log("balance of user 7: ", beebox.UserBalanceByAddr(addr7));
    //     console.log("balance of user 8: ", beebox.UserBalanceByAddr(addr8));
    //     console.log("balance of user 9: ", beebox.UserBalanceByAddr(addr9));

    //     console.log("After 9th user joinning");

    //     vm.prank(addr10);
    //     beebox.Invest(9, 100, 10);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));
    //     console.log("balance of user 6: ", beebox.UserBalanceByAddr(addr6));
    //     console.log("balance of user 7: ", beebox.UserBalanceByAddr(addr7));
    //     console.log("balance of user 8: ", beebox.UserBalanceByAddr(addr8));
    //     console.log("balance of user 9: ", beebox.UserBalanceByAddr(addr9));
    //     console.log("balance of user 10: ", beebox.UserBalanceByAddr(addr10));

    //     console.log("After 10th user joinning");

    //     vm.prank(addr11);
    //     beebox.Invest(10, 100, 11);
    //     console.log("balance of user 1: ", beebox.UserBalanceByAddr(addr1));
    //     console.log("balance of user 2: ", beebox.UserBalanceByAddr(addr2));
    //     console.log("balance of user 3: ", beebox.UserBalanceByAddr(addr3));
    //     console.log("balance of user 4: ", beebox.UserBalanceByAddr(addr4));
    //     console.log("balance of user 5: ", beebox.UserBalanceByAddr(addr5));
    //     console.log("balance of user 6: ", beebox.UserBalanceByAddr(addr6));
    //     console.log("balance of user 7: ", beebox.UserBalanceByAddr(addr7));
    //     console.log("balance of user 8: ", beebox.UserBalanceByAddr(addr8));
    //     console.log("balance of user 9: ", beebox.UserBalanceByAddr(addr9));
    //     console.log("balance of user 10: ", beebox.UserBalanceByAddr(addr10));
    //     console.log("balance of user 11: ", beebox.UserBalanceByAddr(addr11));

    // }   

    // function test_ROI() public {
        

    //     console.log("owner: ", msg.sender);
    //     address add = vm.addr(7);
    //     vm.prank(add);
    //     beebox.Invest(0, 100, 1);
    //     uint bal = beebox.UserBalanceByAddr(add);
    //     console.log("balance after package: ", bal);

    //     for(uint i = 0; i < 199; i++) {
    //         beebox.dailyROI();
    //     }

    //     bal = beebox.UserBalanceByAddr(add);
    //     console.log("balance after 199 times ROI: ", bal);

    //     beebox.dailyROI();
    //     bal = beebox.UserBalanceByAddr(add);
    //     console.log("balance after 200 times ROI: ", bal);

    //     beebox.dailyROI();
    //     bal = beebox.UserBalanceByAddr(add);
    //     console.log("balance after 201 times ROI: ", bal);
    //     add = vm.addr(7);
    //     vm.prank(add);
    //     beebox.Invest(0, 100, 1);

    //     bal = beebox.UserBalanceByAddr(add);
    //     console.log("balance after new package: ", bal);

    //     beebox.dailyROI();
    //     bal = beebox.UserBalanceByAddr(add);
    //     console.log("balance after 1st ROI: ", bal);
    // }

    function test_multiplePackages() public {
        console.log("owner: ", msg.sender);
        address add = vm.addr(12);
        vm.prank(add);
        beebox.Invest(0, 100, 1);
        console.log(beebox.UserBalanceByAddr(add));
        vm.prank(add);
        beebox.Invest(0, 100, 1);
        
        console.log(beebox.UserBalanceByAddr(add));
        
    }
}




