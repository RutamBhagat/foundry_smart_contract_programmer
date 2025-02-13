// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";

contract ForkTest is Test {
    IERC20 public dai;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDeposit() public {
        address alice = address(123);

        uint balBefore = dai.balanceOf(alice);
        console.log("balance before", balBefore / 1e18);

        uint totalBefore = dai.totalSupply();
        console.log("total before", totalBefore / 1e18);

        deal(address(dai), alice, 1e6 * 1e18, true);

        uint balAfter = dai.balanceOf(alice);
        console.log("balance after", balAfter / 1e18);

        uint totalAfter = dai.totalSupply();
        console.log("total after", totalAfter / 1e18);
    }
}
