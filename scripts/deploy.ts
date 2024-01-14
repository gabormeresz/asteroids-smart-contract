import { ethers } from "hardhat";
require("dotenv").config({ path: ".env" });

async function main() {
  const metadataURL =
    "https://aquamarine-brave-dove-509.mypinata.cloud/ipfs/QmXiZHeLcNykHcL2RLXrRSWzPDi6Tz8gN5CkhNa7K1xcTq/";

  const signer = await ethers.provider.getSigner();

  const asteroidsContract = await ethers.deployContract("Asteroids", [
    metadataURL,
    signer.address
  ]);

  await asteroidsContract.waitForDeployment();

  console.log("Asteroids Contract Address:", asteroidsContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
