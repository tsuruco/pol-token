// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC20, ERC20Permit} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @custom:security-contact security@polygon.technology
contract Polygon is Ownable, ERC20Permit {
    address public hub;
    uint256 public lastMint;
    uint256 private constant ONE_YEAR = 31536000;

    constructor(address treasury_) ERC20("Polygon", "POL") ERC20Permit("Polygon") {
        _mint(treasury_, 10000000000 * 10 ** decimals());
        _mint(hub, 100000000 * 10 ** decimals());
        lastMint = block.timestamp;
    }

    function mint() external {
        require(block.timestamp >= lastMint + ONE_YEAR, "Polygon: minting not allowed yet");
        lastMint += ONE_YEAR;
        _mint(hub, 1 * totalSupply() / 100);
    }
}
