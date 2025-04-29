// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Person{
    string private name;
    string private surname;

    constructor (string memory _name, string memory _surname) {
        name = _name;
        surname = _surname;
    }

    function setName (string memory _name) public {
         name = _name;
    }

    function setSurname (string memory _surname) public {
         name = _surname;
    }

    function getName () view public returns(string memory) {
         return name;
    }

    function getSurname () view public returns(string memory) {
         return surname;
    }

    function getPerson() view public returns(string memory, string memory){
        return (name, surname);
    }

}