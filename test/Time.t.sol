// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 private startAt;

    // vm.wrap - set block.timestamp to future timestamp
    // vm.roll - set block number
    // skip - increment current timestamp
    // rewind - decrement current timestamp

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() public {
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() public {
        vm.warp(startAt + 2 days);
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testTimestamp() public {
        uint t = block.timestamp;

        // skip - increment current timestamp
        skip(100);
        assertEq(block.timestamp, t + 100);

        // rewind - decrement current timestamp
        rewind(100);
        assertEq(block.timestamp, t);
    }

    function testBlockNumber() public {
        // vm.roll - set block.number
        vm.roll(999);
        assertEq(block.number, 999);
    }
}
