// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MopedShop {
    mapping (address => >bool) buyers;
     uint256public price = 2 ether;
    address public owner;
    address public shopAddress;
    bool fullyPaid; // false
    
    event ItemFullyPaid(uint , address );

    constructor() {
 owner = msg.sender;
 shopAddress = address(this);
    }
    
    function getBuyer(address )   publicviewreturns(bool) {
        require(owner == msg.sender, "You are not an owner!");
        
        return buyers[_addr];
    }
    
    function addBuyer(address ) public {
        require(owner == msg.sender, "You are not an owner!");
        
 buyers[_addr] = true;
    }
    
    function getBalance()   publicviewreturns(uint) {
        return shopAddress.balance;
    }
    
    function withdrawAll() public {
        require(owner == msg.sender && fullyPaid && shopAddress.balance > 0, "Rejected");
        
        address payable receiver = payable(msg.sender);
        
 receiver.transfer(shopAddress.balance);
    }
    
    receive() external payable {
        require(buyers[msg.sender] && msg.value <= price && !fullyPaid, "Rejected");
        
        if(shopAddress.balance == price) {
 fullyPaid = true;
            
            emit ItemFullyPaid(price, shopAddress);
        }
    }
}
