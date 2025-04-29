// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "./Math2Num.sol";

contract Test{

    using Math2Num for uint;

    function testMin(uint a, uint b) public pure returns(uint){
        return Math2Num.min(a, b);
    }

    function testMax(uint a, uint b) public pure returns(uint){
        return Math2Num.max(a, b);
    }

    function testAverage(uint a, uint b) public pure returns(uint){
        return Math2Num.average(a, b);
    }
}