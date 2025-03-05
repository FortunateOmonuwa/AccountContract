// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract SimpleStorage {
    bool hasFundsInWallet = true;
    uint256   fundsInWallet = 7;
    //uint256 amount;
    string accountName = "Fortunate";
    address accountAddress = 0x5FF791d4Fbd1fE7E62B1c4bAbe3138dfCD9A60c4;
    // bytes32 others = "Nothing";
    string public response;
    int256[] secretNumbers ;

    function addMoreFunds(uint amount, address _address) public returns (string memory){
        if (_address == accountAddress && amount > 0) {
            fundsInWallet += amount;
            response = "Funds successfully added";
            return response;
            
        }
        else {
            response = "Operation failed";
            return response;
        }

    }

    function  addSecretNumbers (int256 _numbers) public  {
        
            secretNumbers.push(_numbers);
           
    }

    function viewSecretNumbers () public  view returns (int256[] memory){
        return secretNumbers;
    }
    //view is used to read state from the blockchain
    function viewFunds () public  view returns (uint256){
        return fundsInWallet;
    }
}