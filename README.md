# Crowdfunding

Contract should allow users to contribute funds to a project and allow the project owner to withdraw funds if a certain funding goal is met.

## HOW TO 

to compile the project run:
`forge build`

to run the test:
`forge test`

to deploy and verify contracts:
`forge script --chain sepolia script/Crowdfunding.s.sol:DeployCrowdfunding --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv`

## Requirements

**Contract Address**: [Contract is deployed to this address](https://sepolia.etherscan.io/address/0x303D894341130172236F2e521017Db8a545AF78d)

**Security Explanation**:
 There are 2 security measures in smart contract:

 1. Contract inheriting from OZ Ownable to restrict access to `withdrawAll()` admin function. 
 2. User's function `withdrawDonation` follows [CEI pattern](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html) to guard against reentrancy attacks.

**Working Frontend**:

## Further improvements
