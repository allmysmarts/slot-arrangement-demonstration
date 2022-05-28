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
  });
});
