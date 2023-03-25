// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//import "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
// import "lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol";

/// @title MarketPlace
/// @author Johnson Mavelous
/// @notice you can sell assest/ntf and it has support for multiple tokens

import { ItemDetails, contractDetails } from "./LibAssetData.sol";

library LibAsset {
    
     //   contractDetails ds;
    function setUp(address _nftAddress) internal {
        contractDetails storage ds = assetStorage();
        ds.nftAddress = IERC721(_nftAddress);
        ds.DaiContract= IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        ds.owner = msg.sender;

        ds.DAIusdpriceFeed = AggregatorV3Interface(0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9);
        ds.ETHusdpriceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    }

    function listAsset(uint _tokenItemID) internal   {
        contractDetails storage ds = assetStorage();
        ItemDetails storage _a = ds.itemInfo[_tokenItemID];
        _a.tokenId = _tokenItemID;
        _a.seller = msg.sender;
        _a.status = true;
    } 

// should be a payable function
    function buyAsset(uint _tokenID) internal {
        contractDetails storage ds = assetStorage();
        uint balance = ds.DaiContract.balanceOf(msg.sender);
        require(ds.itemInfo[_tokenID].status == true, "Not For Sale!!!");
        require(balance >= 3.5 ether);
        uint ethUsdCurrentPrice = getETHUSDPrice();
        uint usdtUsdCurrentPrice = getDAIUSDPrice();
        uint _amountInUsdt = (3.5 ether * ethUsdCurrentPrice) / (usdtUsdCurrentPrice);
        ds.DaiContract.transferFrom(msg.sender, address(this), _amountInUsdt);
        ds.nftAddress.transferFrom(ds.owner, msg.sender, _tokenID);
    }

    function getDAIUSDPrice() internal view returns(uint) {
        contractDetails storage ds = assetStorage();
        (, int price, , ,) = ds.DAIusdpriceFeed.latestRoundData();
        return uint256(price);
    }
    
    function getETHUSDPrice() public view returns (uint) {
        contractDetails storage ds = assetStorage();
            ( , int price, , , ) = ds.ETHusdpriceFeed.latestRoundData();
            return uint256(price);
        }

    function assetStorage() internal pure returns(contractDetails storage ds) {
        bytes32 position = keccak256("MARVELOUS_STORAGE_POSITION");
        assembly {
            ds.slot := position
        }
    }
    

}