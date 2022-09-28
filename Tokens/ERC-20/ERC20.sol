// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

//ERC-20: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol

// Interfaz
interface IERC20{
    function totalSupply() external view returns (uint256);
    
    function balanceOf(address account) external view returns (uint256);
    
    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from, 
        address to, 
        uint256 amount
    ) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

}

contract ERC20 is IERC20 {

    mapping(address => uint256) private _balances;
        // Owner(Cristian) => Spender(Pedro) => 10 tokens
    mapping(address => mapping(address => uint256)) private _allowances;
    
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_){
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory){
        return _symbol;
    }

    function decimals() public view virtual returns (uint8) {
        return 18; // Balance 505 -> 5.05 (505 / 10**18)
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256){
        return _balances[account];
    }
    
    function transfer(address to, uint256 amount) public virtual override returns (bool){
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256){
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(
        address from, 
        address to, 
        uint256 amount) public virtual override returns (bool){
            address spender = msg.sender;
            _spendAllowance(from, spender, amount);
            _transfer(from, to, amount);
            return true;
        }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, _allowances[owner][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 substractedValue) public virtual returns (bool) {
        address owner = msg.sender;
        uint currentAllowance = _allowances[owner][spender];
        require(currentAllowance >= substractedValue, "ERC20: decreased allowance below zero");
        unchecked{
            _approve(owner, spender, currentAllowance - substractedValue);
        }
        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount) internal virtual {
            require(from != address(0), "ERC20: transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address");
            _beforeTokenTransfer(from, to, amount);
            uint256 fromBalance = _balances[from];
            require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
            unchecked{
                _balances[from] = fromBalance - amount;
            }
            _balances[to] += amount; 
            emit Transfer(from, to, amount);
            _afterTokenTransfer(from, to, amount);
        }

    function _mint(address account, uint amount) internal virtual{
        require(account != address(0), "ERC: mint to the zro address");
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual{
        require(account != address(0), "ERC20: burn from the zero address");
        _beforeTokenTransfer(account, address(0), amount);
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceed balance");
        unchecked{
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);
        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual{
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(
        address owner, 
        address spender, 
        uint amount
        )internal virtual{
            uint256 currentAllowance = allowance(owner, spender);
            if(currentAllowance != type(uint256).max){
                require(currentAllowance >= amount, "ERC20: insufficient allowance");
                unchecked{
                    _approve(owner, spender, amount);
                }

            }
        }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {

    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}
