// SPDX-License-Identifier: unlicensed
pragma solidity ^0.8.20;

import {Test, Vm, console} from "forge-std/Test.sol";
import {Crowdfunding} from "../src/Crowdfunding.sol";

contract CrowdfundingTest is Test {
    Crowdfunding crowdfunding;

    address owner;
    address user1;
    address user2;

    uint256 goal = 2 ether;
    uint256 deadline = 2 weeks;

    function setUp() public {
        owner = makeAddr("owner");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        deal(user1, 10 ether);
        deal(user2, 10 ether);

        vm.prank(owner);
        crowdfunding = new Crowdfunding(goal, deadline);
    }

    function test_ParametersAfterDeployment() external view {
        assertEq(crowdfunding.deadline(), 2 weeks);
        assertEq(crowdfunding.goal(), 2 ether);
        assertEq(crowdfunding.goalIsMeet(), false);
    }

    function test_UserShouldNotBeAbleToDonateAfterDeadline() external {
        vm.warp(3 weeks);
        vm.expectRevert(Crowdfunding.Crowdfunding_CompainIsEnded.selector);
        vm.prank(user1);
        crowdfunding.donate{value: 0.5 ether}();
    }

    function test_userShouldBeAbleToDonate() public {
        vm.prank(user1);
        crowdfunding.donate{value: 0.5 ether}();

        assertEq(crowdfunding.donations(user1), 0.5 ether);
    }

    function test_userShouldBeAbleToWithdrawHisDonateBeforeGoalIsAchieved()
        public
    {
        vm.prank(user2);
        crowdfunding.donate{value: 1 ether}();

        vm.startPrank(user1);
        crowdfunding.donate{value: 0.5 ether}();
        crowdfunding.withdrawDonation();
        vm.stopPrank();

        assertEq(address(crowdfunding).balance, 1 ether);
        assertEq(address(crowdfunding).balance, 1 ether);
        assertEq(crowdfunding.donations(user1), 0 ether);
    }

    function test_userShouldNotBeToWithdrawDonationIfDonationIsZero() public {
        vm.prank(user1);
        vm.expectRevert(Crowdfunding.Crowdfunding_DonationIsZero.selector);
        crowdfunding.withdrawDonation();
    }

    function test_userShouldNotBeAbleToWithdrawIfGoalIsNotMeet() public {
        vm.prank(user2);
        crowdfunding.donate{value: 1 ether}();

        vm.prank(owner);
        vm.expectRevert(Crowdfunding.Crowdfunding_GoalIsNotAchieved.selector);
        crowdfunding.withdrawAll();
    }

    function test_OwnerShouldBeAbleToWithdrawIfGoalIsAchieved() public {
        vm.prank(user1);
        crowdfunding.donate{value: 1 ether}();
        vm.prank(user2);
        crowdfunding.donate{value: 1 ether}();

        vm.prank(owner);
        crowdfunding.withdrawAll();
        assertEq(owner.balance, 2 ether);
    }
}
