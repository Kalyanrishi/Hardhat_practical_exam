// SPDX-License-Identifier: MIT

// Solidity files have to start with this pragma.
// It will be used by the solidity compiler to validate its version.
pragma solidity ^0.8.24;

import "hardhat/console.sol";

//  The is the main biulding bolck for smart contracts.
contract Token {
    //  Some string typevariables to identify the token.
    string public name = "My Hardhat Token";
    string public symbol = "MHT";

    //  The fixed amount of tokens, stored in an unsingned integer type varaible
    uint256 public totalSupply = 1000000;

    // An address type varaible is used to store ethereim accounts
    address public owner;

    // A mapping is a key/value map. Here we store each accounts balance.
    mapping(address => uint256) balances;

    // The transfer even helps off-chain application understand
    // what happens within your contract.
    event Transfer(address indexed _from, address indexed _to, uint _value);

    /**
    * Contract initialization.
    */
    constructor() {
        // The totalsupply is assigned to the transaction sender, which is the
        // account that is deploying the contract.
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
    * A function to transfer tokens.
    *
    * The 'external' modifer makes a function *only* callable from *outside*
    * the contract.
     */
    function transfer(address to, uint256 amount) external {
        console.log("Sender balance is % tokens", balances[msg.sender]);

        console.log(
            "Sender id sending %s tokens to %s address", amount, to
        );
        // Check if the transaction sender has enough tokens.
        // If 'require' s first argument avaluates to 'false' then the
        //  transaction will revert
        require(balances[msg.sender] >= amount, "Not enough tokens");

        // Transfer the amount
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chain applications of the transfer
        emit Transfer(msg.sender, to, amount);
    }
    /**
    * Read only function to retriveve the token balance of a given account.
    *
    *
    * The 'view' modifier indicates that it doen't modify the contract's
    * state, which allows us to call it without executing a trasaction.
    */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}