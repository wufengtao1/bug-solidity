pragma solidity ^0.8.0;

import "./a.sol";

contract B {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    A public tokenX;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    constructor(string memory _name, string memory _symbol, address _tokenX) {
        name = _name;
        symbol = _symbol;
        totalSupply = 0;
        tokenX = A(_tokenX);
    }
    
    function mint(uint256 _amount) external {
        require(totalSupply + _amount <= 10000, "Exceeds total supply");
        
        if (totalSupply < 1000) {
            require(tokenX.balanceOf(msg.sender) >= _amount * 10, "Insufficient token X balance");
        } else if (totalSupply < 5000) {
            require(tokenX.balanceOf(msg.sender) >= _amount * 20, "Insufficient token X balance");
        } else if (totalSupply < 9000) {
            require(tokenX.balanceOf(msg.sender) >= _amount * 50, "Insufficient token X balance");
        } else {
            require(tokenX.balanceOf(msg.sender) >= _amount * 100, "Insufficient token X balance");
        }
        
    
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
        
        emit Transfer(address(0), msg.sender, _amount);
    }
    
    function getTokenXRequirement(uint256 _amount) internal pure returns (uint256) {
        if (_amount <= 1000) {
            return 10;
        } else if (_amount <= 5000) {
            return 20;
        } else if (_amount <= 9000) {
            return 50;
        } else {
            return 100;
        }
    }
}
