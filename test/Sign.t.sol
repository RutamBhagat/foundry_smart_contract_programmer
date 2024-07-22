// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract SignTest is Test {
    // private ky = 123
    // public key = vm.addr(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign(private key, message hash)

    function testSignature() public pure {
        uint256 privateKey = 123;
        address pubKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("Secret Message");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(signer, pubKey);

        bytes32 invalidMessageHash = keccak256("Invalid Message");

        signer = ecrecover(invalidMessageHash, v, r, s);

        assertTrue(signer != pubKey);
    }
}
