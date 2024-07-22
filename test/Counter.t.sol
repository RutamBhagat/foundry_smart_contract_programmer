// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {stdError} from "forge-std/StdError.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testGetNumber() public view {
        assertEq(counter.getNumber(), 0);
    }

    function testFuzzSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.getNumber(), x);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.getNumber(), 1);
    }

    function testFailDec() public {
        counter.decrement();
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.decrement();
    }

    function testDecrement() public {
        counter.setNumber(1);
        counter.decrement();
        assertEq(counter.getNumber(), 0);
    }
}
