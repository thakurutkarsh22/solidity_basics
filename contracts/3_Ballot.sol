pragma solidity ^0.4.17;
// linter warnings (red underline) about pragma version can igonored!

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender; // msg is the global object
    }

    function enter() public payable { // payable to make the player pay
        require(msg.value > 1 ether); // ether make sure the conversion happen from eth to wei
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players)); // block, now is also a global variable
    }

    function pickWInner() public {
        uint index = random() % players.length;
        players[index].transfer(this.balance); // this -> instance of current contract // balance is the money in the contract
    } 
}


// contract code will go here