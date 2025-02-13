// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

// Examples of deal and hoax
// deal(address, uint) - Set balance of address
// hoax(address, uint) - deal + prank, Sets up a prank and set balance

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private {
        (bool ok, ) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testEthBalance() public view {
        console.log("ETH balance", address(this).balance / 1e18);
    }

    function testSendEth() public {
        uint bal = address(wallet).balance;
        // deal(address, uint) - Set balance of address
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        deal(address(1), 10);
        assertEq(address(1).balance, 10);

        // hoax(address, uint) - deal + prank, Sets up a prank and set balance
        deal(address(1), 100);
        vm.prank(address(1));
        _send(100);

        hoax(address(1), 500);
        _send(500);

        assertEq(address(wallet).balance, bal + 100 + 500);
    }
}
