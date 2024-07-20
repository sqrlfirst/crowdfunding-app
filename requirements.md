# Crowdfunding

Solidity Proficiency Test
Duration: 1 Hour 40 minutes.


Part 1: Smart Contract Development (40 minutes)
Scenario:
You are tasked with creating a simple crowdfunding contract. The contract should allow users to contribute funds to a project and allow the project owner to withdraw funds if a certain funding goal is met. The contract should include the following requirements:
Basic Functionality:
- [x] The contract should be initialized with a funding goal and a deadline.
- [x] Users can contribute funds to the contract.
- [x] Contributions should be tracked by the contributor's address.
- [x] The project owner can withdraw funds if the funding goal is met before the deadline.
- [ ] If the funding goal is not met, contributors should be able to withdraw their contributions.
Security Considerations:
- [x] Implement checks to prevent reentrancy attacks.
- [x] Ensure only the project owner can withdraw the funds when the goal is met.
- [x] Use appropriate access control modifiers.
Efficiency Considerations:
- Optimize gas usage where possible.
- Avoid unnecessary storage writes and reads.

Requirements:
Write the Solidity contract based on the above scenario. Your contract should include functions for:
Initializing the contract with a funding goal and deadline.
Allowing users to contribute funds.
Allowing the project owner to withdraw funds if the goal is met.
Allowing contributors to withdraw their contributions if the goal is not met.

Part 2: Deployment and Verification (60 minutes)
- Deploy the above contract to the Ethereum Sepolia test network using Remix or any other preferred method.
- Provide the deployed contract address.
- Write a short explanation (3-5 sentences) on the security measures you have implemented in your contract.
- Create a small front-end that uses React and deploy it onto AWS amplify so the application can be tested. Use RainbowKit for wallet connections.
Submission:

Contract Address:
Security Explanation:
Working Frontend:
GitHub Repository:


