const HDWalletProvider = require("@truffle/hdwallet-provider")
require("dotenv").config()

module.exports = {
	networks: {
		bsc_testnet: {
			provider: new HDWalletProvider(process.env.DEPLOYMENT_ACCOUNT_KEY, "https://data-seed-prebsc-2-s1.binance.org:8545"),
			network_id: 97,
			gas: 6000000,
			gasPrice: 10000000000, //1 Gwei
			skipDryRun: true
		},
		development: {
			host: "127.0.0.1",
			port: 8546,
			gas: 6000000,
			network_id: "*",
			skipDryRun: true
		},
	},
	compilers: {
		solc: {
			version: "^0.6.6",
		}
	}
}
