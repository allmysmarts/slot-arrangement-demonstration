//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract StorageTest {
  uint8 public a = 7; // slot-0
  uint16 public b =10; // slot-0
  address public d = 0xbE03bCA4D65A86114668697867982Ecfc76f15F8; // slot-0
  bool public bb = true; // slot-0
  uint64 public c = 15; // slot-0

  uint256 public e = 200; // slot-1

  uint8 public f = 40; // slot-2

  uint256 public g = 789; // slot-3
}

contract FakeToken {
    struct Member {
        uint256 id;
        uint64 account;
    }

    /// @dev slot 0, small size variables will be merged into 
    uint32 public a = 0x11;
    uint64 public b = 0x22;
    uint32 public c = 0x33;
    /// @dev slot 1, if bigger than left amount in slot, then assign new one.
    uint144 public d = 0x4444;
    /// @dev slot 2, length of variable size array stored
    uint256[] public e;
    /// @dev slot 3, 4
    Member public owner;
    /// @dev slot 5, after struct, it creates new slot.
    uint32 public f = 0x55;
    /// @dev slot 6
    uint24[] public g;

    bytes32 internal constant ACCESS = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    constructor() {
        owner.id = 0x2022;
        owner.account = 0x528;

        for (uint256 i = 0; i < 99; i++) {
            e.push(i * i + 0xa0);
        }

        for (uint24 i = 0; i < 100; i++) {
            g.push(i + 0x03);
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

    function getSlotNumber(bytes memory slotNo) external pure returns (bytes32) {
        return keccak256(slotNo);
    }
}
