// SPDX-License-Identifier: GPL-3.0

// Author: Wasi
// Date: 08/12/2023


pragma solidity >=0.8.2 <0.9.0;

interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

     /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

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
        uint balance;
        address referredBy;
        uint lastInvestmentTime;
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
        require(
            Token.allowance(msg.sender, address(this)) >= amount * 10 ** Token.decimals(),
            "You have not approved the tokens"
        );
        require(Token.balanceOf(msg.sender)>= amount * 10 ** Token.decimals(), "You dont have enough tokens");

        if(Users[msg.sender].referredBy == address(0)){
            require(Users[reffBy].referredBy != address(0), "Invalid Referral");
            Users[msg.sender].investedAmount = amount * 10 ** Token.decimals();
            Users[msg.sender].referredBy = reffBy;
            Users[msg.sender].lastInvestmentTime = block.timestamp;
            Users[msg.sender].lastWithdrawTime = block.timestamp;
        }else{
            Users[msg.sender].investedAmount += amount * 10 ** Token.decimals();
            // call claim current profit
            Users[msg.sender].lastInvestmentTime = block.timestamp;
            Users[msg.sender].lastWithdrawTime = block.timestamp;
        }
        Token.transferFrom(msg.sender, address(this), amount * 10 ** Token.decimals()); // transfering tokens to contract
        referralAwardToLevels(amount*10**Token.decimals());
    }

    function referralAwardToLevels(uint amount) internal {
        address curr = Users[msg.sender].referredBy;
        for(uint i = 1; i <= 10; i++){
            if(curr == address(0) || curr == owner) break;
            uint reward = (amount * getRewardPercentage(uint8(i))) / 100;
            Users[curr].balance += reward;
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
        uint calculateAmount = getCurrentProfit();
        require(
            calculateAmount > 0,
            "You do not have enough balance"
        );
        
        Token.transfer(msg.sender, calculateAmount);
    }

    function getCurrentProfit() view public returns(uint) {
    address userAddress = msg.sender;
    User storage user = Users[userAddress];

    // Calculate time passed since last withdrawal
    uint currentTime = block.timestamp;
    uint lastWithdrawTime = user.lastWithdrawTime;
    uint timePassed = currentTime - lastWithdrawTime;

    // Calculate profit percentage per second (0.00000578703%)
    uint profitPercentagePerSecond = 578703; // (0.00000578703 * 10^8)

    // Calculate profit based on time and invested amount
    uint investedAmount = user.investedAmount;
    uint profitPerSecond = (investedAmount * profitPercentagePerSecond) / 10**10; // Considering 18 decimal places
    uint totalProfit = profitPerSecond * timePassed;

    return totalProfit;
    }

}