// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../libraries/LibAsset.sol";
import { LibDiamond } from  "../libraries/LibDiamond.sol";

contract AssetFacet {

    function _setUp(address _nftAddress) external {
        LibAsset.setUp(_nftAddress);
    }

    function _listAsset(uint _tokenItemID) external {
        LibAsset.listAsset(_tokenItemID);
    }

    function _buyAsset(uint _tokenID) external {
        LibAsset.buyAsset(_tokenID);
    }

}
