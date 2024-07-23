// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {IntroInvariant} from "../../src/IntroInvariant.sol";

// Topics
// - Invariant
// - Difference between fuzz and invariant
// - Failing invariant tests
// - Passing invariant tests
// - Stats - runs, calls, reverts

contract IntroInvariantTest is Test {
    IntroInvariant private target;

    function setUp() public {
        target = new IntroInvariant();
    }

    function invariant_flag_is_always_false() public view {
        // Note: This test is expected to fail
        assertEq(target.flag(), false);
    }
}
