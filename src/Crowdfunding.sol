// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Crowdfunding is Ownable {
    /// Goal of the crowdfunding
    uint256 public immutable goal;
    /// Deadline of the crowdfunding
    uint256 public immutable deadline;
    /// true when the goal is achieved, false when is not
    bool public goalIsMeet;

    /// Tracks the donations of the user
    mapping(address => uint256) public donations;

    /// fires when the user makes a donation
    event Donated(address indexed user, uint256 amount);
    /// fires when the user withdraws his donation
    event DonationWithdrawed(address indexed user, uint256 amount);
    // fires when the Owner withdraws a donation after the goal is achieved
    event FundsWithdrawedByOwner();

    /// CUSTOM ERRORS to save gas
    error Crowdfunding_CompainIsEnded();
    error Crowdfunding_GoalIsAchieved();
    error Crowdfunding_GoalIsNotAchieved();
    error Crowdfunding_DonationIsZero();
    error Crowdfunding_FaildToSentBack();

    constructor(uint256 _goal, uint256 _deadline) payable Ownable(msg.sender) {
        goal = _goal;
        deadline = _deadline;
    }

    modifier whenGoalIsNotMeet() {
        require(!goalIsMeet, Crowdfunding_GoalIsAchieved());
        _;
    }

    /**
     * This function is called when the user would like to make a donation to the project
     */
    function donate() public payable whenGoalIsNotMeet {
        require(block.timestamp < deadline, Crowdfunding_CompainIsEnded());

        donations[msg.sender] += msg.value;

        emit Donated(msg.sender, msg.value);
    }

    /**
     * This function is called when the user would like to withdraw his donation to the project
     */
    function withdrawDonation() public whenGoalIsNotMeet {
        require(donations[msg.sender] > 0, Crowdfunding_DonationIsZero());
        uint256 userDonation = donations[msg.sender];
        donations[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: userDonation}("");
        require(sent, Crowdfunding_FaildToSentBack());

        emit DonationWithdrawed(msg.sender, userDonation);
    }

    /**
     *  This function is called when the owner would like to withdraw donations after the goal is achieved
     */
    function withdrawAll() public onlyOwner {
        require(
            address(this).balance >= goal,
            Crowdfunding_GoalIsNotAchieved()
        );

        goalIsMeet = true;

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, Crowdfunding_FaildToSentBack());

        emit FundsWithdrawedByOwner();
    }
}
