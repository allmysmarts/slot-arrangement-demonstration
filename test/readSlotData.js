const { expect } = require("chai");
const { ethers } = require("hardhat");

/**
 * @dev This explains how solidity arranges slot for storage variables.
 * Please check contract source code with slot arrangement.
 */
describe("ReadSlotData", function () {
  it("Should return address", async function () {
    const ReadSlotData = await ethers.getContractFactory("ReadSlotData");
    const readSlotData = await ReadSlotData.deploy();
    await readSlotData.deployed();

    let i = 0
    while (i < 10) {
      const data = await readSlotData.readSlot(i)
      console.log(`slot-${i}: `, data.toHexString())
      i++
    }

    // Dynamic size array {e} is located in slot 2
    const dynamicArray1SlotNo = await readSlotData.getSlotNumber("0x0000000000000000000000000000000000000000000000000000000000000002")
    i = 0
    while (i < 10) {
      const data = await readSlotData.readSlot(ethers.BigNumber.from(dynamicArray1SlotNo).add(i))
      console.log(`array-slot-${i}: `, data.toHexString())
      i++
    }

    // Dynamic size array {g} is located in slot 6
    const dynamicArray2SlotNo = await readSlotData.getSlotNumber("0x0000000000000000000000000000000000000000000000000000000000000006")
    i = 0
    while (i < 10) {
      const data = await readSlotData.readSlot(ethers.BigNumber.from(dynamicArray2SlotNo).add(i))
      console.log(`array-slot-${i}: `, data.toHexString())
      i++
    }
  });
});

