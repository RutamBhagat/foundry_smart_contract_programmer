// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Bit} from "../src/Bit.sol";

// Topics
// - fuzz
// - assume and bound
// - stats
// runs - number of tests
// u - mean gas used
// ~ - median gas used

contract FuzzTest is Test {
    Bit public b;

    function setUp() public {
        b = new Bit();
    }

    // This is just a helper function
    function helperFuncMostSignificantBit(
        uint256 x
    ) private pure returns (uint256) {
        uint256 i = 0;
        // right shifting the number by one bit
        while ((x >>= 1) > 0) {
            i++;
        }
        return i;
    }

    function testMostSignificantBitManual() public view {
        assertEq(b.mostSignificantBit(0), 0);
        assertEq(b.mostSignificantBit(1), 0);
        assertEq(b.mostSignificantBit(2), 1);
        assertEq(b.mostSignificantBit(4), 2);
        assertEq(b.mostSignificantBit(8), 3);
        assertEq(b.mostSignificantBit(type(uint256).max), 255);
    }

    function testMostSignificantBitFuzz(uint256 x) public view {
        // input x will be randomly assigned by foundry

        // assume - If false, the fuzzer will discard the current fuzz inputs and start a new fuzz run
        // Skip x = 0
        // vm.assume(x > 0);
        // assertGt(x, 0);

        // bound(input, min, max) - bound input between min and max
        x = bound(x, 1, 10);
        assertGe(x, 1);
        assertLe(x, 10);

        uint i = b.mostSignificantBit(x);
        assertEq(i, helperFuncMostSignificantBit(x));
    }
}
