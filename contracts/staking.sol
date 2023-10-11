// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/* --------- Access Control --------- */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Claimable is Ownable {
    bool isclaimable = false;

    function claimToken(
        address tokenAddress,
        uint256 amount
    ) external onlyOwner {
        IERC20(tokenAddress).transfer(owner(), amount);
    }

    function claimETH(uint256 amount) external onlyOwner {
        (bool sent, ) = owner().call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}

interface IERC20 {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

interface IRouter {
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function getAmountsOut(
        uint256 amountIn,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);
}

contract Staking is Claimable {
    using SafeMath for uint256;
    // Manage user info on contract
    struct PoolInfo {
        uint256 totalStaked;
        uint256 totalStakers;
        uint256 totalRewardDistributed;
    }

    struct UserInfo {
        uint256 stakeAmount;
        uint256 finishedTime;
        uint profit;
    }

    struct Plan {
        uint256 stakeTime;
        uint256 stakePercent;
    }

    address public router;

    PoolInfo public poolInfo;

    mapping(uint => Plan) plans;
    mapping(address => UserInfo) users;

    address public tokenAddress;
    address public busdAddress;
    address public teamAddress;

    uint feeDecimal = 10000;
    uint stakeFee = 10;
    uint unStakeFee = 15;

    // format variable
    constructor() {
        plans[0] = Plan(2592000, 15);
        plans[1] = Plan(7776000, 50);
        plans[2] = Plan(15552000, 140);
        plans[3] = Plan(31104000, 300);
        poolInfo = PoolInfo(0, 0, 0);
    }

    // set token address
    function setTokenAddress(address _tokenAddress) public onlyOwner {
        tokenAddress = _tokenAddress;
    }

    function setBusdAddress(address _tokenAddress) public onlyOwner {
        busdAddress = _tokenAddress;
    }

    function setRouterAddress(address _address) public onlyOwner {
        router = _address;
    }

    // set token address
    function setTeamAddress(address _teamAddress) public onlyOwner {
        teamAddress = _teamAddress;
    }

    // get current pool info
    function getUser(address _address) public view returns (UserInfo memory) {
        return users[_address];
    }

    // get current user info
    function getPool() public view returns (PoolInfo memory) {
        return poolInfo;
    }

    function stake(uint256 _amount, uint _planId) public {
        UserInfo memory currentInfo = getUser(msg.sender);
        require(currentInfo.stakeAmount == 0, "This user has unstaked amount");

        require(
            IERC20(tokenAddress).transferFrom(
                msg.sender,
                address(this),
                _amount
            ),
            "deposit failed"
        );

        uint256 finishedTime = block.timestamp + plans[_planId].stakeTime;
        uint256 profit = (_amount * plans[_planId].stakePercent).div(
            feeDecimal
        );
        currentInfo.stakeAmount = _amount;
        currentInfo.finishedTime = finishedTime;
        currentInfo.profit = profit;
        users[msg.sender] = currentInfo;
        IERC20(tokenAddress).transfer(
            teamAddress,
            (currentInfo.stakeAmount * stakeFee).div(feeDecimal)
        );
        poolInfo.totalStaked += _amount;
        poolInfo.totalStakers += 1;
    }

    function _approve(address _token, uint _amount) internal {
        IERC20(_token).approve(address(router), _amount);
    }

    function unStake(bool isFTT) public {
        UserInfo memory currentInfo = getUser(msg.sender);
        require(currentInfo.stakeAmount > 0, "This user did not stake yet");
        require(
            block.timestamp > currentInfo.finishedTime,
            "Please wait until unstake time"
        );
        if (isFTT) {
            require(
                IERC20(tokenAddress).transfer(
                    msg.sender,
                    currentInfo.stakeAmount + currentInfo.profit
                ),
                "Sent failed"
            );
        } else {
            _approve(
                tokenAddress,
                currentInfo.stakeAmount + currentInfo.profit
            );
            address[] memory path = new address[](2);
            path[0] = tokenAddress;
            path[1] = busdAddress;

            IRouter(router).swapExactTokensForTokens(
                currentInfo.stakeAmount + currentInfo.profit,
                0,
                path,
                msg.sender,
                block.timestamp
            );
        }

        IERC20(tokenAddress).transfer(
            teamAddress,
            ((currentInfo.stakeAmount + currentInfo.profit) * unStakeFee).div(
                feeDecimal
            )
        );
        poolInfo.totalRewardDistributed += currentInfo.profit;
        users[msg.sender] = UserInfo(0, 0, 0);
    }

    receive() external payable {}

    fallback() external payable {}
}
