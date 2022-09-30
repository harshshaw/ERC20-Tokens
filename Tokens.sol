// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Token{
    mapping(address=>uint256) balances;
    mapping(address=>mapping(address=>uint256)) allowed;

    uint256 totalSupply_;
    constructor(uint256 total) public{
        totalSupply_=total;
        balances[msg.sender]=totalSupply_;
    }

    function totalSupply() public view returns(uint256){
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns(uint256){
        return balances[tokenOwner];
    }
    
    event Transfer(address owner,address reciever,uint256 numTokens);

    function transfer(address reciever,uint numTokens)public  returns(bool){
        require(numTokens<=balances[msg.sender]);
        balances[msg.sender]-=numTokens;
        balances[reciever]+=numTokens;
        emit Transfer(msg.sender,reciever,numTokens);
        return true;
        
    }

    event Approval(address owner,address delegate,uint256 numTokens);

    function approve(address delegate,uint numTokens)public returns (bool){
        allowed[msg.sender][delegate]=numTokens;
        emit Approval(msg.sender,delegate,numTokens);
        return true;
    }

    function allowance(address owner,address delegate) public view returns(uint){
        return allowed[owner][delegate];
    }

    function transferFrom(address owner,address buyer,uint numTokens) public returns (bool){
        require(numTokens<=balances[owner]);
        require(numTokens<=allowed[owner][msg.sender]);
        balances[owner]=balances[owner]-numTokens;
        allowed[owner][msg.sender]-=numTokens;
        balances[buyer]+=numTokens;
        emit  Transfer(owner,buyer,numTokens);
        return true;

    }
    
}
