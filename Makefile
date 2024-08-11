-include .env

build:
	forge build

deploy-sepolia:
	forge script ./script/DeployFundMe.s.sol --rpc-url $(RPC_SEPOLIA) --broadcast --private-key $(PRIVATE_KEY_SEPOLIA) --verify $(ETHERSCAN_API_KEY)
