// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <= 0.9.0;


import "hardhat/console.sol";


/**
*@title Dice Game.
*@author ABossOfMyself.
*@notice Created a Dice Game contract that allows users to roll the dice to try and win the prize. If players roll either a "0", "1", or "2" they will win the current prize amount.
*/


contract DiceGame {

    uint256 public nonce = 0;

    uint256 public prize = 0;


    event Roll(address indexed player, uint256 roll);

    event Winner(address winner, uint256 amount);



    constructor() payable {

        resetPrize();
    }



    function resetPrize() private {

        prize = ((address(this).balance * 10) / 100);
    }



    function rollTheDice() public payable {

        require(msg.value >= 0.002 ether, "Failed to send enough value");

        bytes32 prevHash = blockhash(block.number - 1);

        bytes32 hash = keccak256(abi.encodePacked(prevHash, address(this), nonce));

        uint256 roll = uint256(hash) % 16;

        console.log('\t',"   Dice Game Roll:",roll);

        nonce ++;

        prize += ((msg.value * 40) / 100);

        emit Roll(msg.sender, roll);

        if(roll > 2 ) {

            return;
        }

        uint256 amount = prize;

        (bool sent, ) = msg.sender.call{value: amount}("");

        require(sent, "Failed to send Ether");

        resetPrize();

        emit Winner(msg.sender, amount);
    }



    receive() external payable {}
}