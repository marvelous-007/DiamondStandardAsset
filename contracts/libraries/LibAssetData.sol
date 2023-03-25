// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


    struct ItemDetails {
        uint tokenId;
        address seller;
        bool status;
    }

    struct contractDetails {
        address owner;
        IERC721 nftAddress;
        IERC20 DaiContract;
        AggregatorV3Interface  ETHusdpriceFeed;
        AggregatorV3Interface  DAIusdpriceFeed;
        mapping(uint => ItemDetails) itemInfo;
    }
