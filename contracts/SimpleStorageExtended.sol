// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {SimpleStorage} from "contracts/SimpleStorage.sol";

//Inheritance
contract SimpleStorageExtended is SimpleStorage{

    function addSecretNumbers(int256 num) public override{
        secretNumbers.push(num + 5);
    }
}