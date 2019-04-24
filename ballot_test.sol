pragma solidity >=0.4.0 <=0.6.0;

contract AsparagusSurvey{
    uint likeAsparagus; // public generates a getter, but not a setter unlike java
    uint hateAsparagus;
    
    mapping(address => bool) voted; // it's like a Map on c++
    
    address payable owner;
    
    bool stop = false;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function stopVoting() public{
        require(owner == msg.sender);
        
        stop = true;
        
    }
    
    function destroyContract() public{
        require(owner == msg.sender);
        
        selfdestruct(owner);
    }
    
    
    
    function vote(bool _iLikeAsparagus) public returns(uint[2] memory results){
        require(voted[msg.sender]==false);
        require(msg.sender != owner, "The owner cannot vote");
        require(stop == false, " voting stopped");
            if(_iLikeAsparagus)
                likeAsparagus++;
            else
                hateAsparagus++;
        
        
        voted[msg.sender] = true; // msg is a global object
                                        // msg.sender the transaction's sender's address  
                                        
        results = getResults();
        // return results;
    }
    
    function getResults() public view returns(uint[2] memory){
        uint[2] memory results;
        
        
        results[0] = likeAsparagus;
        results[1] = hateAsparagus;
        
        return results;
    }
}