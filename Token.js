const { expect } = require("chai");

describe("Token contract", function () {

    it("Deployment should assign the total supply of tokens to the owner", async function () {

        const [owner] = await ethers.getSigners();

        console.log("Signers Object: ", owner);

        const hardhatToken = await ethers.deployContract("Token");  // Deploying the contract

        const ownerBalance = await hardhatToken.balanceOf(owner.address);

        console.log("The balance of Owner: ",ownerBalance); // 1000000

        console.log("Owner Address: ",owner.address); // Address of the owner

        expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);

    });
    
    it("Should transfer tokens between accounts", async function() {

        const [owner, addr1, addr2] = await ethers.getSigners();

        const hardhatToken = await ethers.deployContract("Token");

        // Transfer 50 tokens from owner to addr1
        await hardhatToken.transfer(addr1.address, 60);

        expect(await hardhatToken.balanceOf(addr1.address)).to.equal(60);

        // Transfer 50 tokens from addr1 to addr2
        await hardhatToken.connect(addr1).transfer(addr2.address, 60);

        expect(await hardhatToken.balanceOf(addr2.address)).to.equal(60);
    });
});