// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract Lib {
    address public owner;

    function pwn() public {
        owner = msg.sender;
    }
}
