const fs = require("fs");
const colors = require("colors");
const { ethers } = require("hardhat");
const { toBigNum } = require("./utils.js");
async function main() {
  // get network
  let [owner] = await ethers.getSigners();
  console.log(owner.address);
  let network = await owner.provider._networkPromise;

  const ERC20TOKEN = await ethers.getContractFactory("ERC20");
  tokenContract = await ERC20TOKEN.deploy("Pexdos", "PXDS");
  await tokenContract.deployed();

  let price = 30000 * 1000000;
  const PresaleContract = await ethers.getContractFactory("BTC30_Presale");
  presaleContract = await PresaleContract.deploy(tokenContract.address, price);
  await presaleContract.deployed();

  await tokenContract.transfer(presaleContract.address, toBigNum("1000", 18));
}

main()
  .then(() => {
    console.log("complete".green);
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
