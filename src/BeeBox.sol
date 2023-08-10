// SPDX-License-Identifier: GPL-3.0

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

contract BeeBox {
    address public owner;
    IERC20 private Token;
    uint[] private IDS;

    // ALL MAPPINGS //
    mapping(uint => address) public ReferralToAddress;
    mapping(address => uint) public UsersReferralCodes;
    mapping(address => uint) public UserBalanceByAddr;
    mapping(uint => uint[]) public Referrals;
    mapping(address => uint) public ReferredBy;
    mapping(address => uint) public SelectedPackage;
    mapping(address => uint) public TotalProfit;

    constructor(address tokenAddress) {
        owner = msg.sender;
        ReferralToAddress[0] = msg.sender;
        Token = IERC20(tokenAddress);
    }

    function referralAwardToLevels() public {
        uint[] memory CurrLevelReffs = new uint[](Referrals[UsersReferralCodes[msg.sender]].length);

        for(uint i = 0; i < Referrals[UsersReferralCodes[msg.sender]].length; i++) {
            UserBalanceByAddr[ReferralToAddress[CurrLevelReffs[i]]] += (SelectedPackage[msg.sender] * getRewardPercentage(1)) / 100;
        }
        
        
        for(uint i = 0; i < 10; i++){
            uint[] memory NextLevelReffs = new uint[](getCurrentLevelLength(CurrLevelReffs));

            for(uint j = 0; j < NextLevelReffs.length ; j++){

            }
        }
        
        
    }

    function getCurrentLevelLength(uint[] memory reffs) view public returns(uint){
        uint count;
        for(uint i = 0; i < reffs.length; i++){
            count += Referrals[reffs[i]].length;
        }
        return count;
    }

    function getRewardPercentage(uint8 level) internal pure returns (uint) {
        if (level == 1) return 6;
        if (level == 2) return 4;
        if (level >= 3 && level <= 6) return 2;
        if (level >= 7 && level <= 9) return 1;
        if (level == 10) return 1;
        return 0; // Default to 0% for unsupported levels
    }

    function Invest(
        uint reffCode,
        uint amount,
        uint generatedReffCode
    ) public returns (bool) {
        // remove the addr and set msg.sender once project is for live
        require(
            amount <= 5000 && amount >= 100,
            "You can not deposit more than $5000 and less than $100"
        );
        require(msg.sender != owner, "Owner can not join pool");
        Token.transferFrom(msg.sender, address(this), amount * 10 ** 6); // transfering tokens to contract
        if (UsersReferralCodes[msg.sender] != 0) {
            UserBalanceByAddr[msg.sender] += amount * 10 ** 6;
            SelectedPackage[msg.sender] += amount * 10 ** 6;
        } else {
            require(
                ReferralToAddress[reffCode] != address(0),
                "referral code does not exist"
            );

            // -- setting refferel code and address -- //
            if (ReferralToAddress[generatedReffCode] == address(0)) {
                UsersReferralCodes[msg.sender] = generatedReffCode;
                ReferralToAddress[generatedReffCode] = msg.sender;
                IDS.push(generatedReffCode);
            } else {
                return false;
            }

            UserBalanceByAddr[msg.sender] = amount * 10 ** 6; // setting balance with 6 zeros at the end
            SelectedPackage[msg.sender] = UserBalanceByAddr[msg.sender];
            // -- adding increments to inviter stats -- //
            Referrals[reffCode].push(UsersReferralCodes[msg.sender]); // pushing current user referral code to the referral's array
            ReferredBy[msg.sender] = reffCode; // setting referral code

            referralAwardToLevels();
        }
    }

    
}
