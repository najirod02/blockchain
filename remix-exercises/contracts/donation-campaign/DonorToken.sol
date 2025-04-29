// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

import "./DonorBadge.sol";

contract DonorToken is ERC20, ERC20Permit {

    DonorBadge private badgeContract; // in order to generate new badges

    struct Donation {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => Donation[]) private donationHistory;

    uint constant private initialSupply = 1000 * (10 ** 18); // 1000 tokens with 18 decimals

    // donation campaign details
    uint8 private feePercentage;
    uint256 private campaignGoal;
    uint256 private totalDonations;
    uint256 private campaignEndTime;
    address private organizer;
    address private charity;

    // event to give to the user when they donate tokens
    event Donated(address indexed donor, uint256 amount, string message);
    event Withdrawn(address indexed charity, uint256 amount, string message);
    event FeeTransferred(address indexed organizer, uint256 feeAmount, string message);
    event Badge(address indexed recipient, string message);

    constructor(uint256 goal, uint256 duration, uint8 _feePercentage, address _organizer, address _charity) ERC20("DonorToken", "DTK") ERC20Permit("DonorToken") {
        badgeContract = new DonorBadge(address(this));
        
        _mint(msg.sender, initialSupply);

        organizer = _organizer;
        charity = _charity;
        campaignGoal = goal;
        feePercentage = _feePercentage;
        campaignEndTime = block.timestamp + duration;
    }

    function donate(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens");
        require(block.timestamp < campaignEndTime, "Campaign has ended");

        // calculate fee amount
        uint256 feeAmount = (amount * feePercentage) / 100;
        uint256 donationAmount = amount - feeAmount;

        // transfer fee to organizer and remaining amount to charity
        _transfer(msg.sender, organizer, feeAmount);
        _transfer(msg.sender, address(this), donationAmount);

        // record the donation 
        donationHistory[msg.sender].push(
            Donation({ amount: amount, timestamp: block.timestamp })
        );

        totalDonations += donationAmount;

        emit Donated(msg.sender, amount, "Thank you for donating!");
        emit FeeTransferred(organizer, feeAmount, "Trasferred fee to organizer");

        badgeContract.mintBadge(msg.sender);

        emit Badge(msg.sender, "Congratulations! You have received a badge!");
    }

     function withdraw() public {
        require(msg.sender == charity, "Only charity can withdraw");
        require(block.timestamp >= campaignEndTime || totalDonations >= campaignGoal, "Goal not met or campaign not ended");

        uint256 amountToWithdraw = totalDonations;
        totalDonations = 0; // as the donations are withdrawn

        _transfer(address(this), charity, amountToWithdraw);

        emit Withdrawn(charity, amountToWithdraw, "Donaations withdrawn!");
    }

    function getUserDonations(address donor) public view returns (Donation[] memory) {
        return donationHistory[donor];
    }

}