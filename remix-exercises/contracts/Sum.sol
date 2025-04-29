// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Sum {
    
    event SumCalculated(uint a, uint b, uint result);

    function sum(uint a, uint b) public returns (uint) {
        uint result = a + b;
        emit SumCalculated(a, b, result);
        return result;
    }

}