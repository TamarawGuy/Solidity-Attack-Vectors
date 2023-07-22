const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Attack", function () {
  async function deploy() {
    const [deployerBank, deployerAttacker, firstUser, secondUser] =
      await ethers.getSigners();

    const Bank = await ethers.getContractFactory("Bank", deployerBank);
    const bank = await Bank.deploy();

    const Attacker = await ethers.getContractFactory(
      "Attacker",
      deployerAttacker
    );
    const attacker = await Attacker.deploy(bank.target, {
      value: ethers.parseEther("1"),
    });

    return { bank, attacker, deployerBank, deployerAttacker, firstUser };
  }

  describe("Deployment", function () {
    it("should deploy", async function () {
      const { bank, attacker, deployerBank, deployerAttacker, firstUser } =
        await loadFixture(deploy);

      const bankFirstUser = bank.connect(firstUser);
      await bankFirstUser.deposit({ value: ethers.parseEther("3") });

      await attacker.attack({ value: ethers.parseEther("1") });
      expect(await attacker.getOwnerBalance()).to.be.greaterThan(10000);
    });
  });
});
