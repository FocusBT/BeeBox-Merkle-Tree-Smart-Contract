// SPDX-License-Identifier: GPL-3.0

// Author: Wasi
// Date: 08/12/2023
pragma solidity >=0.8.2 <0.9.0;
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/**
 * @title BeeBox
 * @dev A smart contract that allows users to invest in a token called USDT and earn referral rewards.
 */
contract BeeBox {
    address public owner;
    IERC20 private Token;
    address private tokenAddress = 0xc2132D05D31c914a87C6611C10748AEb04B58e8F; // USDT address 

    struct User {
        uint investedAmount;
        uint totalProfit;
        address referredBy;
        uint lastWithdrawTime;
    }

    mapping(address => User) public Users;



    constructor() {
        owner = msg.sender;
        Users[msg.sender].referredBy = address(0x1);
        Token = IERC20(tokenAddress);
    }


    function Invest(uint amount, address reffBy) public {
         require(
           amount >= 2000,
            "Min amount to invest is $2000"
        );

        if(Users[msg.sender].referredBy == address(0)){
            require(reffBy != msg.sender, "Invalid Referral.");
            require(Users[reffBy].referredBy != address(0), "Invalid Referral");
            Users[msg.sender].investedAmount = amount * 10 ** 18;
            Users[msg.sender].referredBy = reffBy;
            Users[msg.sender].lastWithdrawTime = block.timestamp;
        }else{
            if(Users[msg.sender].investedAmount>0 && Users[msg.sender].lastWithdrawTime != block.timestamp){
                withdraw();
            }
            Users[msg.sender].investedAmount += amount * 10 ** 18;
            Users[msg.sender].lastWithdrawTime = block.timestamp;
        }
        Token.transferFrom(msg.sender, address(this), amount * 10 ** 18); // transfering tokens to contract
        referralAwardToLevels(amount*10**18);
    }

    function referralAwardToLevels(uint amount) internal {
        address curr = Users[msg.sender].referredBy;
        for(uint i = 1; i <= 10; i++){
            if(curr == address(0) || curr == owner) break;
            uint reward = (amount * getRewardPercentage(uint8(i))) / 100;
            Token.transfer(curr, reward);
            curr = Users[curr].referredBy;
        }
    }
    
    
    // change token address
    function changeTokenAddress(address _tokenAddress) public {
        require(msg.sender == owner, "You are not allowed to change token address");
        tokenAddress = _tokenAddress;
        Token = IERC20(tokenAddress);
    }

    
    
    function changeOwnership(address _owner) public {
        require(msg.sender == owner, "You are not allowed to change ownership");
        owner = _owner;
        Users[_owner].referredBy = address(0x1);
    }

    

    

    function getRewardPercentage(uint8 level) internal pure returns (uint) {
        if (level == 1) return 6;
        if (level == 2) return 4;
        if (level == 3) return 4;
        if (level >= 4 && level <= 7) return 2;
        if (level >= 8 && level <= 10) return 1;
        return 0; // Default to 0% for unsupported levels
    }

    

    function withdraw() public {
        require(Users[msg.sender].investedAmount > 0, "Invest First");
        uint calculateAmount = getCurrentProfit();
        

        if(Users[msg.sender].totalProfit+calculateAmount >= Users[msg.sender].investedAmount ){
            uint lastWithdraw = (Users[msg.sender].investedAmount * 2) - Users[msg.sender].totalProfit; 
            Token.transfer(msg.sender, lastWithdraw);
            Users[msg.sender].investedAmount = 0;
            Users[msg.sender].lastWithdrawTime = 0;
            Users[msg.sender].totalProfit = 0;
        }else {
            require(
            calculateAmount > 0,
            "You do not have enough balance"
            );
            Users[msg.sender].totalProfit += calculateAmount;
            Users[msg.sender].lastWithdrawTime = block.timestamp;
            Token.transfer(msg.sender, calculateAmount);
        }
        
    }

    function getCurrentProfit() view public returns(uint) {
    // Calculate time passed since last withdrawal
        uint currentTime = block.timestamp;
        uint lastWithdrawTime = Users[msg.sender].lastWithdrawTime;
        uint timePassed = currentTime - lastWithdrawTime;

    // Calculate profit percentage per second (0.00000578703%)
        uint256 RATE_PER_SECOND = 578703; // 0.00000005787% * 1e8
        uint256 DECIMALS = 1e13; // Scaling factor

        uint256 totalProfit = (Users[msg.sender].investedAmount * RATE_PER_SECOND * timePassed) / DECIMALS;
        return totalProfit;
    }

}

