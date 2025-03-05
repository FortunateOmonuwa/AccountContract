// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "contracts/Account.sol";

contract AccountManager{

    Account private accountContract;
    constructor(address _accountAddress){
        accountContract = Account(_accountAddress);
    }

    function CreateWalletOrAccount(string memory _phoneNumber, string memory _email, string[] memory _secrets) public returns (Account.UserAccount memory) {
        return accountContract.CreateAccount(_phoneNumber, _email, _secrets);
    }

    function ViewAllAccountsOrWallets() public view returns (Account.UserAccount[] memory ){
        return accountContract.viewAccounts();
    }
}