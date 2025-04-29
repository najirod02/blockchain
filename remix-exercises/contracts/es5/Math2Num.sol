// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

/**
rememebr that libraries has no state

there is no float nor double data type in order to maintain security and 
determinism in smart contracts.
a possible solution is to use scaled integers to encode float values e.g:

instead of 1.23, we write 123 and when needed we just divide by 100.

*/
library Math2Num {
    function min(uint a, uint b) external pure returns(uint){
        return (a < b) ? a : b;
    }

    function max(uint a, uint b) external pure returns(uint){
        return (a > b) ? a : b;
    }

    function average(uint a, uint b) external pure returns(uint){
        return (a+b)/2;
    }
}