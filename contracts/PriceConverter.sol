// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConverter{
    
    function getPrice(AggregatorV3Interface avInterface) internal view returns (uint256) {
        (,int256 answer,,,) = avInterface.latestRoundData();

        return uint256(answer) * 1e10;
    }

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface avInterface) internal view returns (uint256){
        uint256 ethPrice = getPrice(avInterface);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return  ethAmountInUsd;
    }
    function getVersion(AggregatorV3Interface avInterface) internal   view returns (uint256){
        return avInterface.version();
    }
}