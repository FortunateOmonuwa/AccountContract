// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Account{

    //bytes32 private secret = "ux323r32n28fnxufreie8459itnfw000";
    struct UserAccount{
        uint id;
        address walletAddress;
        string email;
        string phoneNumber;
        uint256 balance;
        bool isVerified;
        bytes32[] secretPhrases;
    }
    UserAccount[] accounts;

    mapping (uint => UserAccount) private  specificAccount;
    uint private currentId = 1;
    function CreateAccount(string memory _phoneNumber, string memory _email, string[] memory _secrets) external returns ( UserAccount memory){
        require(bytes(_phoneNumber).length >= 10, "Invalid Phonenumber");
        require(bytes(_email).length >= 10, "Invalid email");
        require(_secrets.length > 5, "Secrets can't be less than 5");
    
        bytes32[] memory secrets = new bytes32[](_secrets.length);
        for (uint256 i = 0; i < _secrets.length; i++) 
        {
            bytes32 allPhrases = keccak256(bytes(_secrets[i]));
            secrets[i] = allPhrases;
        }
        UserAccount memory newAccount = UserAccount({
            id: currentId,
            walletAddress : msg.sender,
            email : _email,
            phoneNumber : _phoneNumber,
            balance : 0,
            isVerified : false,
            secretPhrases : secrets
        });

        accounts.push(newAccount);
        currentId+=1;
        specificAccount[currentId] = newAccount;
        return  newAccount;
    }

    function viewAccounts() external view  returns (UserAccount[] memory){
        return accounts;
    }

    function ViewAccountByID(uint256 _id) external  view returns(UserAccount memory){
        UserAccount memory account = specificAccount[_id];
        return  account;
    }
}