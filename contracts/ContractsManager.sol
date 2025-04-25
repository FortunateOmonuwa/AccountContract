// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {Account} from "contracts/Account.sol";
import {SimpleStorage} from "contracts/SimpleStorage.sol";
import {AccountManager} from "contracts/AccountMgt.sol";

contract ContractsManager{

    
    AccountManager public  accMgt;

    mapping (uint => AccountManager) public  accountManagers;
    Account[] public  listOfAccountContracts;
    SimpleStorage[] public simpleStorages;


    uint public  accountContractId = 1;
    function DeployAccountContract() public  {
        Account newAcc = new Account();
        listOfAccountContracts.push(newAcc);
    }

    function DeployStorage() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorages.push(simpleStorage);
    }

    function DeployAccManager(address accAddress) public {
        accMgt = new AccountManager(accAddress);
        accountManagers[accountContractId] = accMgt;
        accountContractId++;
    }

    function AddFavouriteNum(uint256 index, int num) public {
        SimpleStorage mySimpleStorage = simpleStorages[index];
        mySimpleStorage.addSecretNumbers(num);
    }

    function ViewFavouriteNumbers(uint index) public view returns (int[]  memory ){
         return  simpleStorages[index].viewSecretNumbers();
         
    }


}