pragma solidity ^0.5.1;
// declare version of solidity

// imports the other solidity file with the TOKEN
import "./Token.sol";

contract TokenTimelock {
    // state variable, assign address to state variable
    // DATATYPE: Token; DECLARED: public; ADDRESS: token;
    Token public token;

    // address of who gets the token
    address public beneficiary;
    
    // the release time of the tokens
    uint256 public releaseTime;

    // constructor function sets these values up when
    // the contract is deployed
    constructor(
        
        // DATATYPE: Token, PASS IN: _token (to the constructor)
        Token _token, 
        // DATATYPE: address, PASS IN: _beneficiary (to the const.)
        address _beneficiary, 
        // DATATYPE: uint256, PASS IN: _releaseTime
        uint256 _releaseTime
    ) 
        
        public 
    {
        // code inside the function

        // require that the release time is past the block's
        // time stamp
        require(_releaseTime > block.timestamp);
        token = _token;
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
    }

    // release whatever tokens belong to the contract
    // to the beneficiary
    function release() public {
        
        // ensures that this only happens after selected
        // time is passed.
        require(block.timestamp >= releaseTime);

        //Check the balance of the smart contract
        // THIS: refers to the smart contract
        // ADDRESS: ensures it's converted to address type
        uint256 amount = token.balanceOf(address(this));
        // require that the balance is greater than 0
        require(amount > 0);

        //transfer the tokens
        token.transfer(beneficiary, amount);
    }
}
