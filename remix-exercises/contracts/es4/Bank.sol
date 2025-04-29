// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

/**
a simple Bank system where a user can deposit or withdraw money.
it is similar to the Counter exercises but in this case we need to include
some checks on the available balance before allowing any withdraw, in this case,
require() will be used as we will give back all gas not already used.
*/
contract Bank{

    //in this case only one bank accoutn exists but using a mapping we can store more than one
    uint private balance = 0;

    constructor (uint initial_balance){
        require(initial_balance >=0, "Initial balance must be greater or equal than zero!");
        balance = initial_balance;
    }

    function deposit(uint money) public returns(uint){
        require(money > 0, "You cannot deposit a negative value!");
        balance += money;
        return balance;
    }

    /**
    the function works properly but a consideration needs to be done.
    by putting the require as second row, we would spend more gas instead of having it at the first
    row in the case we need to revert the transaction.
    this is voluntary leaved as it is to show how different implementations would have different costs.
    */
    function withdraw(uint money) public returns(uint){
        balance-=money;
        require(balance >=0, "You cannot be in debit! Reverting transaction.");
        return balance;
    }

    function getBalance() public view returns(uint){
        return balance;
    }
}