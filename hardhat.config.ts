require("dotenv").config({ path: ".env" });
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const ALCHEMY_MUMBAI_RPC_URL = process.env.ALCHEMY_MUMBAI_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    mumbai: {
      url: ALCHEMY_MUMBAI_RPC_URL,
      accounts: [PRIVATE_KEY!]
    }
  }
};

export default config;
