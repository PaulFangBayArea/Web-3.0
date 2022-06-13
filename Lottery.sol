//SPDX-License-Identifier: MIT

// compiler version must be greater than or equal to 0.8.10 and less than 0.9.0
pragma solidity ^0.8.0;

contract Lottery {
    //the owner of the contract
    address public owner;

    //players in the contract
    address[] public players;

    //set the owner of the contract
    function setOwner() public {
        owner = msg.sender;
    }

    //add new players
    function addPlayer() public payable {
        //require each player to pay a certain amount of ether to enter
        require(msg.value == 1 ether);
        players.push(msg.sender);
    }

    //create a random hash that will will be used to choose the winner
    function random() private view returns (uint) {
        return uint (keccak256(abi.encode(block.timestamp,players)));
    }

    //restrict access
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    //pick the winner
    function pickWinner() public onlyOwner {
        uint index = random() % players.length;
        //pay the winner picked randomly
        payable(players[index]).transfer(address(this).balance);
        //empty the old lottery
        players = new address[](0);
    }
}
 
