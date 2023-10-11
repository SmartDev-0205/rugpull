const { expect } = require("chai");
const fs = require("fs");
const { ethers } = require("hardhat");

const { delay, fromBigNum, toBigNum } = require("./utils.js");
const { mine } = require("@nomicfoundation/hardhat-network-helpers");

var owner, addr1, addr2;
var tokenContract, hirokiToken2;

describe("deploy contracts", function() {
  it("Create account", async function() {
    [owner, addr1, addr2] = await ethers.getSigners();
    console.log("This is owner address : ", owner.address);
    console.log("This is add1 address : ", addr1.address);
    console.log("This is add2 address : ", addr2.address);
    var tx = await owner.sendTransaction({
      to: addr1.address,
      value: toBigNum("100", 18),
    });
    await tx.wait();

    var tx = await owner.sendTransaction({
      to: addr2.address,
      value: toBigNum("100", 18),
    });
    await tx.wait();
  });

  it("deploy contracts", async function() {
    //QE token deployment
    const ERC20TOKEN = await ethers.getContractFactory("ERC20");
    tokenContract = await ERC20TOKEN.deploy("Token1", "T1");
    await tokenContract.deployed();

    hirokiToken2 = await ERC20TOKEN.deploy("Token2", "T2");
    await hirokiToken2.deployed();

    const Staking = await ethers.getContractFactory("Staking");
    stakingContract = await Staking.deploy();
    await tokenContract.deployed();

    stakingContract.setTokenAddress(tokenContract.address);
    stakingContract.setTeamAddress(addr1.address);
    tokenContract.transfer(stakingContract.address, toBigNum("100000000", 18));
    tokenContract.transfer(addr2.address, toBigNum("100000000", 18));
    stakingContract.setBusdAddress(hirokiToken2.address);
  });
});

describe("Exchange deploy and deploy", function() {
  it("Factory deploy", async function() {
    const Factory = await ethers.getContractFactory("DEXFactory");
    exchangeFactory = await Factory.deploy(owner.address);
    await exchangeFactory.deployed();
    console.log(await exchangeFactory.INIT_CODE_PAIR_HASH());
    console.log(exchangeFactory.address);
  });

  it("WETH deploy", async function() {
    const WETH = await ethers.getContractFactory("WETH");
    wETH = await WETH.deploy();
    await wETH.deployed();
    console.log(wETH.address);
  });

  it("Router deploy", async function() {
    const Router = await ethers.getContractFactory("DEXRouter");
    exchangeRouter = await Router.deploy(exchangeFactory.address, wETH.address);
    await exchangeRouter.deployed();
    console.log(exchangeRouter.address);
    stakingContract.setRouterAddress(exchangeRouter.address);
  });

  it("Tokens Add Liquidity", async function() {
    var tx = await hirokiToken2.approve(
      exchangeRouter.address,
      toBigNum("100000000", 18)
    );
    await tx.wait();

    var tx = await tokenContract.approve(
      exchangeRouter.address,
      toBigNum("1000000", 18)
    );
    await tx.wait();

    tx = await exchangeRouter.addLiquidity(
      tokenContract.address,
      hirokiToken2.address,
      toBigNum("1000000", 18),
      toBigNum("100000000", 18),
      0,
      0,
      owner.address,
      "111111111111111111111"
    );
    await tx.wait();

    var amount = await exchangeRouter.getAmountsOut(toBigNum("1", 18), [
      tokenContract.address,
      hirokiToken2.address,
    ]);
    console.log("amount", amount);
  });
});

describe("contracts test", function() {
  it("Checking the contract", async function() {
    var tx = await tokenContract
      .connect(addr2)
      .approve(stakingContract.address, toBigNum("1000", 18));
    await tx.wait();

    var busdBlanace = await hirokiToken2.balanceOf(addr2.address);
    console.log("first busd balance", busdBlanace);

    tx = await stakingContract.connect(addr2).stake(toBigNum("1000", 18), 1);
    await tx.wait();

    console.log("Check user status after the staking ");
    let userInfo = await stakingContract.connect(addr2).getUser(owner.address);
    console.log(userInfo);

    console.log("Check pool status after the staking ");
    let poolInfo = await stakingContract.connect(addr2).getPool();
    console.log(poolInfo);

    console.log("wait 3 months");
    await mine(7776000);

    console.log("unstake");

    console.log("unstake");
    tx = await stakingContract.connect(addr2).unStake(false);
    await tx.wait();

    console.log("Check user status after the unStaking ");
    userInfo = await stakingContract.connect(addr2).getUser(owner.address);
    console.log(userInfo);

    console.log("Check pool status after the unStaking ");
    poolInfo = await stakingContract.connect(addr2).getPool();
    console.log(poolInfo);

    busdBlanace = await hirokiToken2.balanceOf(addr2.address);
    console.log("Busd balance", busdBlanace);
    busdBlanace = await tokenContract.balanceOf(addr2.address);
    console.log("our token balance", busdBlanace);
  });
});
