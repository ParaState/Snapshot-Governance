//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

abstract contract StateToken {
  function balanceOf(address _owner) external view virtual returns (uint256);
}

abstract contract CompoundStakingReward {
    function calculateSharesValueInState(address user) external view virtual returns (uint256);
}


contract ProxyReader {
    address public stateTokenAddr;
    address public stakingAddr;

    constructor(address _stateTokenAddr, address _stakingAddr) {
        stateTokenAddr = _stateTokenAddr;
        stakingAddr = _stakingAddr;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return StateToken(stateTokenAddr).balanceOf(_owner) + 2 * CompoundStakingReward(stakingAddr).calculateSharesValueInState(_owner);
    }
}
