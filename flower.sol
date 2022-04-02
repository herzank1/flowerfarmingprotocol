
//pragma abicoderv2;
//pragma solidity 0.5.16;
pragma experimental ABIEncoderV2;

interface IBEP20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint8);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

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
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

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
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
  // Empty internal constructor, to prevent people from mistakenly deploying
  // an instance of this contract, which should be used via inheritance.
  constructor () internal { }

  function _msgSender() internal view returns (address payable) {
    return msg.sender;
  }

  function _msgData() internal view returns (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return sub(a, b, "SafeMath: subtraction overflow");
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    uint256 c = a - b;

    return c;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return div(a, b, "SafeMath: division by zero");
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    // Solidity only automatically asserts when dividing by 0
    require(b > 0, errorMessage);
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    return mod(a, b, "SafeMath: modulo by zero");
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts with custom message when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b != 0, errorMessage);
    return a % b;
  }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
  address   private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
   */
  constructor () internal {
    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }

  /**
   * @dev Returns the address of the current owner.
   */
  function owner() public view returns (address) {
    return _owner;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(_owner == _msgSender(), "Ownable: caller is not the owner");
    _;
  }

  /**
   * @dev Leaves the contract without owner. It will not be possible to call
   * `onlyOwner` functions anymore. Can only be called by the current owner.
   *
   * NOTE: Renouncing ownership will leave the contract without an owner,
   * thereby removing any functionality that is only available to the owner.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   * Can only be called by the current owner.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

//FLOWER farming 


contract Farming{
  using SafeMath for uint256;
  
    mapping (address => bool) members; //only investors become a member
    mapping (address => address) referrals; //referral list
    mapping (address => field[]) fields; //

    address HeadWallet = 0x7fe108160192BAE9a17c9594b2A33fCc0ff2Af56;
    
    uint8 referralCommission = 8; //occurs when an _sow happens  //uint 0 to 225 max value
    uint8 HeadWalletCommission = 2;    //occurs when an _sow happens

    uint256 month = 2629743; //1 month = 2629743 sec


    function _register(address _referral) external returns (bool) {
        //check if already referred

        if(_referral == HeadWallet){
          referrals[msg.sender] = HeadWallet;

        }else{
        require(members[_referral],"this address is not a member");
        address ref = referrals[msg.sender];//check if hasbeen refered
        require(ref == address(0),"you have been referred by some one");
        require(_referral != address(0),"you must be referred by someone");
        require(_referral != msg.sender,"you can't reffer to yourself");
        referrals[msg.sender] = _referral;

        }
        
        
        return true;
    }


    // gets referrals address
    function _getReferral(address _address) external view returns (address) {
        return referrals[_address];
    }


    //removes field by index
    function _removeField(address _address, uint8 _fieldIndex)internal returns (bool){
    
      uint256 inv_count = fields[_address].length; // gets investiments address
      fields[_address][_fieldIndex] = fields[_address][inv_count-1];
      fields[_address].pop();

      if (inv_count > fields[_address].length ){
      return true;

      }else {
      return false;

      }
       
    }

    //register field in mapping 
    function _recordField(address _address, uint256 _mount, uint256 _mountReturn, uint256 _duration,uint8 _plan)internal returns (bool){

       uint256 count = fields[_address].length;
        field memory n;

        n.id = count;
        n.mount = _mount;
        n.timeStamp = block.timestamp;
        n.returnMount = _mountReturn;  //includes yield
        n.duration = _duration;
        n.plan = _plan;

        fields[_address].push(n);

        return true;


    }

    function _getFieldsCount(address _address)external view returns (uint256){
        return fields[_address].length;

    }

    function _getField(address _address,uint8 index)external view returns (field memory){
       field memory get = fields[_address][index];
        return get;

    }

    function _getFieldReadable(address _address,uint256 index)external view returns (
      
        uint256 _id,
        uint256 _mount,
        uint256 _returnMount,
        uint256 _timeStamp,
        uint256 _duration,
        uint8 _plan

    ){

          field memory n =fields[_address][index];

         _id = n.id;
         _mount = n.mount;
         _returnMount = n.returnMount;
         _timeStamp = n.timeStamp;
         _duration = n.duration;
         _plan = n.plan;

    }

    function _getFields(address _address)external view returns (field[] memory){
        return fields[_address];

    }

    function _checkIfHarvestIsReady(address _address, uint256 fieldIndex)internal returns (bool){
      
      field memory get = fields[_address][fieldIndex];

       require(get.timeStamp > 0,"Error field time");

       if (block.timestamp> (get.timeStamp + get.duration)){
          return true;
       }else{

         return false;
       } 
      
       

     }

     function getCurrentTimeStamp()external view returns (uint256){

       return block.timestamp;
     }

    //structure of invenstiments

    struct field {
        uint256 id;
        uint256 mount;
        uint256 timeStamp;
        uint256 duration;
        uint256 returnMount;//in % example 150%
        uint8 plan;


    }

    function _referralCommission() external view returns (uint256){
        return referralCommission;
    }

    function _headWalletCommission () external view returns (uint256){
        return HeadWalletCommission ;
    }
   

}

contract BEP20Token is Farming, Context, IBEP20, Ownable {

event sow(address indexed _from, uint _value);
event re_sow(address indexed _from, uint _value);
event harvest(address indexed _to, uint _value);
event sell_flower(address indexed _from, address indexed _to, uint _value);
event buy_flower(address indexed _from, address indexed _to, uint _value);


  using SafeMath for uint256;

  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowances;

  address DEAD = 0x000000000000000000000000000000000000dEaD;
  
  
  uint256 private _totalSupply;
  uint8 private _decimals;
  string private _symbol;
  string private _name;

/*when totalsupply reached maxtotalsupply
 investments and reinvestments were closed 
 unless burns were made.*/

  uint256 private _totalMaxSupply; 

  constructor() public {
    _name = "FLOWER";
    _symbol = "FLOWER";
    _totalSupply = 0;
    _decimals = 18;
    _totalMaxSupply = 5 * 10**14 * 10**18;

      uint256 initialSupply = 1000 * 10**18;
    _balances[msg.sender] = initialSupply; //Creator first reserve
    _totalSupply = initialSupply;
  }

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address) {
    return owner();
  }

/**
   * @dev Returns the max supply.
   */
  function maxTotalSupply() external view returns (uint256) {
    return _totalMaxSupply;
  }
  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint8) {
    return _decimals;
  }

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory) {
    return _symbol;
  }

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory) {
    return _name;
  }

  /**
   * @dev See {BEP20-totalSupply}.
   */
  function totalSupply() external view returns (uint256) {
   // return _totalSupply - _balances[DEAD];
    return internalTotalSupply();

  }

  function internalTotalSupply() internal view returns (uint256) {
    return _totalSupply - _balances[DEAD];
  }

  

  /**
   * @dev See {BEP20-balanceOf}.
   */
  function balanceOf(address account) external view returns (uint256) {
    return _balances[account];
  }

  /**
   * @dev See {BEP20-transfer}.
   *
   * Requirements:
   *
   * - `recipient` cannot be the zero address.
   * - the caller must have a balance of at least `amount`.
   */
  function transfer(address recipient, uint256 amount) external returns (bool) {
    _transfer(_msgSender(), recipient, amount);
    return true;
  }


//send tokens to DEAD wallet
  function burn(address _from, uint256 _amount)internal returns (bool){
    _transfer(_from, DEAD, _amount);
    return true;
  }

  //send tokens to DEAD wallet
  function _burn(uint256 _amount)external returns (bool){
    burn(msg.sender,_amount);
    return true;
  }

  /**
   * @dev See {BEP20-allowance}.
   */
  function allowance(address owner, address spender) external view returns (uint256) {
    return _allowances[owner][spender];
  }

  /**
   * @dev See {BEP20-approve}.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function approve(address spender, uint256 amount) external returns (bool) {
    _approve(_msgSender(), spender, amount);
    return true;
  }

  /**
   * @dev See {BEP20-transferFrom}.
   *
   * Emits an {Approval} event indicating the updated allowance. This is not
   * required by the EIP. See the note at the beginning of {BEP20};
   *
   * Requirements:
   * - `sender` and `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   * - the caller must have allowance for `sender`'s tokens of at least
   * `amount`.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
    _transfer(sender, recipient, amount);
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));
    return true;
  }

  /**
   * @dev Atomically increases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    return true;
  }

  /**
   * @dev Atomically decreases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   * - `spender` must have allowance for the caller of at least
   * `subtractedValue`.
   */
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));
    return true;
  }


  /**
   * @dev Moves tokens `amount` from `sender` to `recipient`.
   *
   * This is internal function is equivalent to {transfer}, and can be used to
   * e.g. implement automatic token fees, slashing mechanisms, etc.
   *
   * Emits a {Transfer} event.
   *
   * Requirements:
   *
   * - `sender` cannot be the zero address.
   * - `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   */
  function _transfer(address sender, address recipient, uint256 amount) internal {
    require(sender != address(0), "BEP20: transfer from the zero address");
    require(recipient != address(0), "BEP20: transfer to the zero address");

    _balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");
    _balances[recipient] = _balances[recipient].add(amount);
    emit Transfer(sender, recipient, amount);
  }

  /**
   * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
   *
   * This is internal function is equivalent to `approve`, and can be used to
   * e.g. set automatic allowances for certain subsystems, etc.
   *
   * Emits an {Approval} event.
   *
   * Requirements:
   *
   * - `owner` cannot be the zero address.
   * - `spender` cannot be the zero address.
   */
  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "BEP20: approve from the zero address");
    require(spender != address(0), "BEP20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }

 
    function getContractBalance()external view returns (uint256){
        return address(this).balance;
    }


    function _sow(uint8 _planIndex) external payable{

        require( internalTotalSupply() <= _totalMaxSupply,"This is the end of the FLOWER HYIP unless users burn thei FLOWERS");
        address ref = referrals[msg.sender];
        require(ref != address(0),"you must be referred by a member");
        require(_planIndex <= 3 && _planIndex > 0 ,"Plan not exist");
        
        uint256 _duration; //month = 2629743 secs.
        uint256 _returnMount; //in %

        if (_planIndex == 1){

            require(msg.value >= 100000000000000 &&  msg.value <= 10000000000000000000 ,"minimum and maximun for this plan is: 0.0001 to 10 ETH/BNB");
            _duration = month; //1 month
            _returnMount = 115; //115%

        }else if (_planIndex == 2){
          require(msg.value >= 10000000000000000 &&  msg.value <= 100000000000000000000 ,"minimum and maximun for this plan is: 0.01 to 100 ETH/BNB");
            _duration = month * 2; // 2 months
             _returnMount = 150; //150%

        }else if (_planIndex == 3){
          require(msg.value >= 1000000000000000000 &&  msg.value <= 1000000000000000000000 ,"minimum and maximun for this plan is: 1 to 1000 ETH/BNB");
          _duration = month * 4; // 4 months
           _returnMount = 275; //275%

        }

        uint256 tokens = msg.value;// seed tokens

        uint256 refferalFeeTokens = tokens.div(100).mul(referralCommission);  
        uint256 HeadWalletCommissionFeeTokens = tokens.div(100).mul(HeadWalletCommission); //this for HeadWallet

        uint256 flowerToGenerate = tokens.div(100).mul(_returnMount); //generate newa tokens


        bool registerSuccess = _recordField(msg.sender,tokens, _returnMount, _duration, _planIndex);
        require(registerSuccess,"Error adding field");


        //Flower generation
        _balances[address(this)] += flowerToGenerate;
        _balances[ref] += refferalFeeTokens;
        _balances[HeadWallet] += HeadWalletCommissionFeeTokens;

        _totalSupply += flowerToGenerate + refferalFeeTokens + HeadWalletCommissionFeeTokens;

        members[msg.sender]=true;//

        emit sow(msg.sender, tokens);
    }

   
    function  _re_sow(uint _fieldIndex)external returns(bool){
      require( internalTotalSupply() <= _totalMaxSupply,"This is the end of the FLOWER Farming unless users burn their FLOWERS");
       
      require(_checkIfHarvestIsReady(msg.sender,_fieldIndex) ,"the harvest's time has not been completed" );
      
      field memory get = fields[msg.sender][_fieldIndex];

        address ref = referrals[msg.sender];
        require(ref != address(0),"you must be referred by someone");

        get.timeStamp = block.timestamp; //set time over again

        uint256 profit = get.mount.div(100).mul(get.returnMount);
        uint256 prevMount = get.mount;

        get.mount =  profit; //change update mount to new mount

        fields[msg.sender][_fieldIndex] = get; //set field to new variables
        
        uint256 tokens = get.mount;// re_sow in tokens

        uint256 refferalFeeTokens = tokens.div(100).mul(referralCommission);  
        uint256 HeadWalletCommissionFeeTokens = tokens.div(100).mul(HeadWalletCommission); //this for HeadWallet

        //Flower generation
        _balances[address(this)] += profit.sub(prevMount);
        _balances[ref] += refferalFeeTokens;
        _balances[HeadWallet] += HeadWalletCommissionFeeTokens;

        uint256 generateTokens;
        generateTokens = profit.sub(prevMount) + refferalFeeTokens + HeadWalletCommissionFeeTokens;

        _totalSupply += generateTokens;

        emit re_sow(msg.sender, tokens);

    }

   

     function _harvest(uint8 _fieldIndex)external returns (bool){


       require(_checkIfHarvestIsReady(msg.sender,_fieldIndex) ,"the harvest time has not been completed" );
       field memory get = fields[msg.sender][_fieldIndex];
       uint256 TotalReturn = get.mount.div(100).mul(get.returnMount); //gets total _sow returns
       require(_removeField(msg.sender,_fieldIndex),"Harvest error!!"); //remove field from address investments list
       
       if(_balances[address(this)]>= TotalReturn){

        _balances[address(this)] -= TotalReturn; //take flower from contract, supost that has been generate on _sow time
        _balances[msg.sender] += TotalReturn; //update FLOWER balance

       }else{

                                             //take flower from contract, supost that has been generate on _sow time
        _balances[msg.sender] += TotalReturn; //update FLOWER balance
        _totalSupply += TotalReturn;

       emit Transfer(address(this), msg.sender, TotalReturn);
       }
        
       emit harvest(msg.sender, TotalReturn);
       return true;

     }

    //user sends flower and gets BNB from reserve
    function _sell_flowers(uint256 _flowers)external  returns (bool) {

      //this function convers FLOWERS to BNB

      require(_balances[msg.sender] >= _flowers,"not enougth tokens to redeem");
      require(_flowers >= 10000000000000000 && _flowers <= 1000000000000000000000  , "the range is between 0.01 to 1000 BNB/ETH");
      require(address(this).balance >= _flowers, "have been not received enough investments, invite more members to invest, this is how it works!!");

      _balances[msg.sender] -= _flowers; //sender substract flower
      _balances[address(this)] += _flowers;

      address payable to = msg.sender;
      to.send(_flowers.div(100).mul(98)); //pay to user 98% in BNB

      emit sell_flower(msg.sender,address(this),_flowers);
      return true;
    }

    //user sends BNB and gets FLOWER from reserve or address(0)
     function _buy_flowers() external payable{

        require( internalTotalSupply() <= _totalMaxSupply,"This is the end of the FLOWER Farming unless users burn their FLOWERS");
        require(msg.value >= 10000000000000,"buy at least 10000000000000 wei");

        uint256 tokens =  msg.value;
        uint256 tokensReturn = tokens.div(100).mul(98);
        uint256 tokensToHeadWallet = tokens.div(100).mul(10); //head gets 10% each user's buy

        if(_balances[address(this)] >= tokensReturn){

          _balances[address(this)] -= tokensReturn; //subtract flower from contract
          _balances[msg.sender] += tokensReturn; //user recives 98% in FLOWER
          _balances[HeadWallet] += tokensToHeadWallet; 

          _totalSupply += tokensToHeadWallet;

         emit buy_flower(address(this), msg.sender, tokensReturn);
         emit buy_flower(address(this), HeadWallet, tokensToHeadWallet);


        }else{
          //if contract balances is not enogth, generate Flowers
          _balances[msg.sender] += tokensReturn; //user recives 98% in FLOWER
          _balances[HeadWallet] += tokensToHeadWallet; 

          _totalSupply += tokensReturn.add(tokensToHeadWallet);

         emit buy_flower(address(0), msg.sender, tokensReturn);
         emit buy_flower(address(0), HeadWallet, tokensToHeadWallet);


        }

        
        
    }


}
