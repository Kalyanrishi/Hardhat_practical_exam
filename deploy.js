const hre = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const token = await ethers.deployContract("Token");

    console.log("Token address:", await token.getAddress());

    console.log("Account balance:", (await deployer.provider.getBalance(deployer.address)).toString());
}


main()
   .then(() => process.getMaxListeners(0))
   .catch((error) => {
    console.error(error);
    process.exit(1);
   });