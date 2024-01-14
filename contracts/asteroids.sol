// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Asteroids is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string _baseTokenURI;
    uint256 public maxTokenIds = 100;
    uint256 public maxMintPerAddress = 1;
    uint256 public tokenIds;

    constructor(
        string memory baseURI,
        address initialOwner
    ) Ownable(initialOwner) ERC721("Asteroids", "AST") {
        _baseTokenURI = baseURI;
    }

    function mint() public {
        require(tokenIds < maxTokenIds, "Exceed maximum Asteroids supply");
        require(
            balanceOf(msg.sender) < maxMintPerAddress,
            "Maximum mint per wallet exceeded"
        );

        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function setMaxMintPerAddress(uint256 maxMint) public onlyOwner {
        require(maxMint >= 1 && maxMint <= 10);
        maxMintPerAddress = maxMint;
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(
            tokenId > 0 && tokenId <= totalSupply(),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory baseURI = _baseURI();

        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    receive() external payable {}

    fallback() external payable {}
}
