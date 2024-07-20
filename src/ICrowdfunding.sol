// SPDX-License-Identifier: unlicensed
pragma solidity ^0.8.20;

interface ICrowdfunding {
    function donate() external;

    function withdrawDonation() external;
}
