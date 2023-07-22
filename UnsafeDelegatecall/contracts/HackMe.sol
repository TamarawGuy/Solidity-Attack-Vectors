// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import {Lib} from './Lib.sol';

contract HackMe {
    address public owner;
    Lib public lib;

    constructor(address _lib) {
        owner = msg.sender;
        lib = Lib(_lib);
    }

    fallback() external payable {
        (bool sent, ) = address(lib).delegatecall(msg.data);
        require(sent, "Failed to delegatecall");
    }

    receive() external payable {}
}