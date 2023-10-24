pragma solidity ^0.8.0;

import "./b.sol";

contract A {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        totalSupply = 0;
    }
    
    function mint(address _to, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        
        balanceOf[_to] += _amount;
        totalSupply += _amount;
        
        emit Transfer(address(0), _to, _amount);
    }
    
    function transfer(address _to, uint256 _amount) external {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        
        emit Transfer(msg.sender, _to, _amount);
    }
}