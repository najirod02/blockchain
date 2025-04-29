// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "../es2/Person.sol";

contract Addressbook {
    struct Entry {
        string phone;
        string _address;
    }

    mapping(bytes32 => Entry) private addressbook;

    function addEntry(Person person, Entry memory entry) public {
        bytes32 key = keccak256(abi.encodePacked(address(person)));
        addressbook[key] = entry;
    }

    function getEntry(Person person) public view returns (Entry memory) {
        bytes32 key = keccak256(abi.encodePacked(address(person)));
        return addressbook[key];
    }
}
