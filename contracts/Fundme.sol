//send money {deposi}...send money into this contract
//withdraw funds
//Set a minimum funding value in USD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

//Importing aggregator which allows me to get data feeds from chainlink oracles
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "contracts/PriceConverter.sol";
contract FundMe{
    
    //Allows me to call the functions in this PriceConverter library directly for types of uint256
    using PriceConverter for uint256;

    //5 dollars, but in 18 decimal places
    //use constant keeyword if it won't change and write the variable name in all caps
    uint256 public minimumUsd = 5e18;
    AggregatorV3Interface private avInterface;

    address[] public funders;

    mapping(address funder => uint256 amount) public  addressToAmount;

    //mark as immutable since it doesn't change but needs to be set elsewhere
    //immutable variables have a convention of i_ before the variable name. e.g i_owner
    //immutable and constant saves the variable on the byte code 
    address public owner;
    constructor(){
        avInterface = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        owner = msg.sender;
    }
    function fund() public payable{
        uint256 ethVal = msg.value.getConversionRate(avInterface);
        require(ethVal >= minimumUsd, "Value has to be greater than or equal to ");

        funders.push(msg.sender);
        addressToAmount[msg.sender] += msg.value;
    }

    //Assuming they want to withdraw the whole money in their account;
    function withdraw() public onlyOwner{
       
        for (uint256 i = 0; i < funders.length; i++) 
        {
            address funderAddress = funders[i];
            addressToAmount[funderAddress] = 0;
        }

        //
        funders = new address[](0);


        //TRANSFER
        //Transfering funds to whoever calls the withdrawal function
        //The this keyword here refers to the address of this contract
        // //You need to add the payable keyword to msg.sender so it becomes a payable address
        // payable(msg.sender).transfer(address(this).balance);

        // //SEND
        // bool sendReq = payable (msg.sender).send(address(this).balance);
        // require(sendReq, "Send failed");

        //CALL
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    //withdrawing from specific account
    // function withdraw(address walletAddress, uint amount) public returns (string memory){
        
    //     uint256 currentBalance = addressToAmount[walletAddress];
    //     require( currentBalance >= amount, "You're trying to withdraw more than you have");
        
    //     addressToAmount[walletAddress] -= amount;

    //     return  "Withdrawal successful";
    // }

    //Modifiers allows us to create a keyword that can be put in functions declaration to add functionalitites
    //if the underscore is above the code, it means the code will executed first
    modifier onlyOwner(){
         require(msg.sender == owner, "Address doesn't own contract");
         _;
    }
}