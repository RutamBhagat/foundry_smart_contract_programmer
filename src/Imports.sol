// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "solmate/tokens/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20("name", "symbol", 18) {}

contract TestOz is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}
}
