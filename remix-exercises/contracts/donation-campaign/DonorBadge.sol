// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DonorBadge is ERC721, Ownable{
    
    uint256 private tokenIds;

    constructor(address initialOwner) ERC721("DonorBadge", "DBG") Ownable(initialOwner) {}

    function mintBadge(address recipient) external onlyOwner returns (uint256) {
        tokenIds += 1;
        _mint(recipient, tokenIds);
        return tokenIds;
    }

}
