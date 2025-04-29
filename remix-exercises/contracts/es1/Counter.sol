// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract Counter{
    uint256 private counter;

    constructor () {
        counter = 0;
    }

    function increment () public returns(uint256) {
        return ++counter;
    }

    function decrement () public returns(uint256) {
        return --counter;
    }

    function reset () public returns(uint256) {
        counter = 0;
        return counter;
    }
}