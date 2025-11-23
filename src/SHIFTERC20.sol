// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @notice SHIFT ERC20 Token
contract SHIFTERC20 is ERC20 {
    uint8 private _tokenDecimals = 18;

    constructor(
        string memory name_,
        string memory string_,
        uint decimals_
    ) ERC20(name_, symbol_) {
        _tokenDecimals = decimals_;
    }

    function decimals() public view override returns (uint8) {
        return _tokenDecimals;
    }

    /// @notice Mint freely
    function mint(address to_, uint256 amount_) external {
        _mint(to_, amount_);
    }

    /// @notice Burn freely
    function burn(address from_, uint256 amount_) external {
        _burn(from_, amount_);
    }
}
