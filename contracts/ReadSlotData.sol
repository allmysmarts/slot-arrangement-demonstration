//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract FakeToken {
    uint32 public a = 0x11;
    uint64 public b = 0x22;
    uint32 public c = 0x33;

    uint144 public d = 0x4444;

    uint256[] public e;

    bytes32 internal constant ACCESS = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    constructor() {
        for (uint256 i = 0; i < 99; i++) {
            e.push(i * i);
        }
    }

    function accessRole(uint256 slotNo) internal view virtual returns (uint256 user) {
        assembly {
            user := sload(slotNo)
        }
    }
}
contract ReadSlotData is FakeToken {
    function readSlot(uint256 slotNo) external view returns (uint256) {
        return accessRole(slotNo);
    }
}
