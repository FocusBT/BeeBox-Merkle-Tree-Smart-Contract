pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/BeeBox.sol";
import "../src/MyToken.sol";

contract TestBeeBox is Test {
    BeeBox public beebox;
    MyToken public mytoken;
    address public owner;
    struct User {
        uint investedAmount;
        uint totalProfit;
        uint balance;
        address referredBy;
        uint lastInvestmentTime;
        uint lastWithdrawTime;
    }

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

    address public tokenAddr;
    address public contractAddr;


    function setUp() public {
        beebox = new BeeBox();
        contractAddr = address(beebox);
        owner = msg.sender;
        mytoken = new MyToken();
        tokenAddr = address(mytoken);


    }

    // function test_invest() public {
    //     mytoken.mint(addr1, 2000 * 10 ** 18);
    //     mytoken.mint(addr2, 2000 * 10 ** 18);
    //     mytoken.mint(addr3, 2000 * 10 ** 18);
    //     mytoken.mint(addr4, 2000 * 10 ** 18);
    //     mytoken.mint(addr5, 2000 * 10 ** 18);
    //     mytoken.mint(addr6, 2000 * 10 ** 18);
    //     beebox.changeTokenAddress(tokenAddr);
    //     beebox.changeOwnership(owner);


    //     vm.prank(addr1);
    //     mytoken.approve(contractAddr, 2000 * 10 ** 18);
    //     vm.prank(addr1);
    //     beebox.Invest(2000, owner);

    //     (uint a,, , address d, uint e, uint f) = beebox.Users(addr1);
    //     // console.log("for user: ", addr1);
    //     // console.log( "investedAmount", a);
    //     // console.log( "referredBy", d);
    //     // console.log( "lastWithdraw", f);
    //     // console.log( "lastInvested", e);

    //     vm.prank(addr2);
    //     mytoken.approve(contractAddr, 2000 * 10 ** 18);
    //     vm.prank(addr2);
    //     beebox.Invest(2000, addr1);

    //     (, uint fg , uint ghd , , , ) = beebox.Users(addr1);
    //     console.log(ghd);

    //     (, fg , ghd , , , ) = beebox.Users(addr2);
    //     console.log(ghd);


        
        
        
    //     (a,, , d, e, f) = beebox.Users(addr2);
    //     // console.log("for user: ", addr2);
    //     // console.log( "investedAmount", a);
    //     // console.log( "referredBy", d);
    //     // console.log( "lastWithdraw", f);
    //     // console.log( "lastInvested", e);

    //     vm.prank(addr3);
    //     mytoken.approve(contractAddr, 2000 * 10 ** 18);
    //     vm.prank(addr3);
    //     beebox.Invest(2000, addr2);

    //     (, fg , ghd , , , ) = beebox.Users(addr1);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr2);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr3);
    //     console.log(ghd);

    //     vm.prank(addr4);
    //     mytoken.approve(contractAddr, 2000 * 10 ** 18);
    //     vm.prank(addr4);
    //     beebox.Invest(2000, addr3);
    //     (, fg , ghd , , , ) = beebox.Users(addr1);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr2);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr3);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr4);
    //     console.log(ghd);

    //     vm.prank(addr5);
    //     mytoken.approve(contractAddr, 2000 * 10 ** 18);
    //     vm.prank(addr5);
    //     beebox.Invest(2000, addr4);

    //     (, fg , ghd , , , ) = beebox.Users(addr1);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr2);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr3);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr4);
    //     console.log(ghd);
    //     (, fg , ghd , , , ) = beebox.Users(addr5);
    //     console.log(ghd);


        
    //     // uint amount =  beebox.Users(addr1).investedAmount;
    //     // console.log(beebox.Users(addr1).investedAmount);
    // }

    function test_ROI() public {
        mytoken.mint(addr1, 2000 * 10 ** 18);
        mytoken.mint(addr2, 2000 * 10 ** 18);
        mytoken.mint(addr3, 2000 * 10 ** 18);
        mytoken.mint(addr4, 2000 * 10 ** 18);
        mytoken.mint(addr5, 2000 * 10 ** 18);
        mytoken.mint(contractAddr, 6000 * 10 ** 18);
        beebox.changeTokenAddress(tokenAddr);
        beebox.changeOwnership(owner);

        vm.warp(0); 
        vm.prank(addr1);
        mytoken.approve(contractAddr, 6000 * 10 ** 18);
        vm.prank(addr1);
        beebox.Invest(2000, owner);

        
        (uint a, uint b , address c, uint d) = beebox.Users(addr1);
        console.log("for user: ", addr1);
        console.log( "investedAmount", a);
        console.log("totalProfit", b);
        console.log( "referredBy", c);
        console.log( "lastWithdraw", d);

        vm.warp(17280000); 

        vm.prank(addr1);
        beebox.withdraw();

        console.log(mytoken.balanceOf(addr1));

        (a, b , c, d) = beebox.Users(addr1);
        console.log("for user: ", addr1);
        console.log( "investedAmount", a);
        console.log("totalProfit", b);
        console.log( "referredBy", c);
        console.log( "lastWithdraw", d);

        vm.warp(87280000);

        vm.prank(addr1);
        beebox.withdraw();
        (a, b , c, d) = beebox.Users(addr1);
        console.log("for user: ", addr1);
        console.log( "investedAmount", a);
        console.log("totalProfit", b);
        console.log( "referredBy", c);
        console.log( "lastWithdraw", d);
        console.log(mytoken.balanceOf(addr1));

        vm.prank(addr1);
        beebox.Invest(2000, address(0));

        (a, b , c, d) = beebox.Users(addr1);
        console.log("for user: ", addr1);
        console.log( "investedAmount", a);
        console.log("totalProfit", b);
        console.log( "referredBy", c);
        console.log( "lastWithdraw", d);
        console.log(mytoken.balanceOf(addr1));
        
        vm.prank(addr1);
        beebox.Invest(2000, address(0));

        vm.warp(104560000); 
        vm.prank(addr1);
        beebox.withdraw();
        (a, b , c, d) = beebox.Users(addr1);
        console.log("for user: ", addr1);
        console.log( "investedAmount", a);
        console.log("totalProfit", b);
        console.log( "referredBy", c);
        console.log( "lastWithdraw", d);
        console.log(mytoken.balanceOf(addr1));

        vm.warp(204560000); 

        vm.prank(addr1);
        beebox.withdraw();
        (a, b , c, d) = beebox.Users(addr1);
        console.log("for user: ", addr1);
        console.log( "investedAmount", a);
        console.log("totalProfit", b);
        console.log( "referredBy", c);
        console.log( "lastWithdraw", d);
        console.log(mytoken.balanceOf(addr1));
        console.log(mytoken.balanceOf(tokenAddr));


        


// 2000000000000000000000
        // console.log(currentProfit);

        // uint256 RATE_PER_SECOND = 578703; // 0.00000005787% * 1e8
        // uint256 DECIMALS = 1e13; // Scaling factor

        // uint amount = 1000 * 10 ** 18;
        // uint secondsElapsed = 86400;

        // // Calculate the profit as (amount * rate * time) / scaling factor
        // // uint _amount = amount * 10 ** 18;
        // uint256 totalProfit = (amount * RATE_PER_SECOND * secondsElapsed) / DECIMALS;
    
        
        // console.log(totalProfit);

        // 4999968000000000000
        // 4999993920000000000
        // 9999987840000000000
        // 1999997568000000000000


        // vm.prank(addr2);
        // mytoken.approve(contractAddr, 2000 * 10 ** 18);
        // vm.prank(addr2);
        // beebox.Invest(2000, addr1);

        // (, uint fg , uint ghd , , , ) = beebox.Users(addr1);
        // console.log(ghd);

        // (, fg , ghd , , , ) = beebox.Users(addr2);
        // console.log(ghd);

        


    }


}