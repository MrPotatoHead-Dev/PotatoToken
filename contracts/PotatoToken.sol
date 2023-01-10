// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PotatoToken is ERC20Capped, Ownable {
    address[] public account;
    uint256 public initialSupply = 6000000;
    uint256 public blockReward;

    constructor(uint256 capAmount, uint256 reward)
        ERC20("PotatoToken", "Tat")
        ERC20Capped(capAmount * 10**decimals())
        onlyOwner
    {
        _mint(owner(), initialSupply * 10 * decimals());
        blockReward = reward * (10**decimals());
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        if (!(from == address(0) && to == block.coinbase)) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }
}
