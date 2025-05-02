//send money {deposi}...send money into this contract
//withdraw funds
//Set a minimum funding value in USD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "contracts/PriceConverter.sol";
contract FundMe{
    
    using PriceConverter for uint256;
    uint256 public minimumUsd = 5e18;
    AggregatorV3Interface private avInterface;

    address[] public funders;

    mapping(address funder => uint256 amount) public  addressToAmount;
    constructor(){
        avInterface = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
    function fund() public payable{
        uint256 ethVal = msg.value.getConversionRate(avInterface);
        require(ethVal >= minimumUsd, "Value has to be greater than or equal to ");

        funders.push(msg.sender);
        addressToAmount[msg.sender] += msg.value;
    }

    //Assuming they want to withdraw the whole money in their account;
    function withdraw() public {
        for (uint256 i = 0; i < funders.length; i++) 
        {
            address funderAddress = funders[i];
            addressToAmount[funderAddress] = 0;
        }
    }

    //withdrawing from specific account
    function withdraw(address walletAddress, uint amount) public returns (string memory){
        
        uint256 currentBalance = addressToAmount[walletAddress];
        require( currentBalance >= amount, "You're trying to withdraw more than you have");
        
        addressToAmount[walletAddress] -= amount;

        return  "Withdrawal successful";
    }
}