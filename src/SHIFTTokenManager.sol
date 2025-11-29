// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {SHIFTERC20} from "src/SHIFTERC20.sol";

/// @notice SHIFT Token Manager
contract SHIFTTokenManager {
    address[] public tokens;
    mapping(string => address) public names;
    address public owner;

    /// @notice Constructor sets the deployer as the owner
    constructor(
        address owner = msg.sender;
    )

    /// @notice Only owner modifier
    modifier onlyOwner()
    {
        require(msg.sender == owner, "Not the owner.");
        _;
    }


    /// @notice Emitt through interaction
    event TokenCreated(
        address indexed token,
        string name,
        string symbol,
        uint8 decimals
    );
    event Minted(address indexed token, address indexed to, uint256 amount);
    event Burned(address indexed token, address indexed from, uint256 amount);

    /// @notice Deploy a new token
    function deploy(
        string calldata name,
        string calldata symbol,
        uint8 decimals
    ) external onlyOwner returns (address) {
        require(names[name] == address(0), "Token name already exists.");

        SHIFTERC20 token = new SHIFTERC20(name, symbol, decimals);
        tokens.push(address(token));
        names[name] = address(token);

        emit TokenCreated(address(token), name, symbol, decimals);
        return address(token);
    }

    /// @notice Mint tokens
    function mint(string calldata name, address to, uint256 amount) external onlyOwner
    {
        address token = names[name];
        require(token != address(0), "Token does not exist.");

        SHIFTERC20(token).mint(to, amount);
        emit Minted(token, to, amount);
    }

    /// @notice Burn tokens
    function burn(string calldata name, address from, uint256 amount) external onlyOwner
    {
        address token = names[name];
        require(token != address(0), "Token does not exist.");

        SHIFTERC20(token).burn(from, amount);
        emit Burned(token, from, amount);
    }

    /// @notice Supply of tokens
    function supply(string calldata name) external view returns (uint256)
    {
        address token = names[name];
        require(token != address(0), "Token does not exist.");

        return SHIFTERC20(token).totalSupply();
    }

    /// @notice Balance of tokens
    function balance(
        string calldata name,
        address account
    ) external view returns (uint256)
    {
        address token = names[name];
        require(token != address(0), "Token does not exist.");

        return SHIFTERC20(token).balanceOf(account);
    }

    /// @notice Return all deployed tokens (public-getter already exists, i.e. token())
}
