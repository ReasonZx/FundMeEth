# Install modules
```
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install eth-brownie
sudo apt install python3.10-venv
sudo npm install -g ganache-cli
```

# Compile

To compile the smart contract, run:
```
brownie compile
```

# Deploy
## Local Network
To deploy on a local network, run:
```
brownie run scripts/deploy.py --network development
```

## Testnet
To deploy on a testnet, get your keys for that testnet and the project id from infura.io.

For example Goerli testnet:
```
$export PUBLIC_KEY="your_public_key"
$export PRIVATE_KEY="your_private_key"
$export WEB3_INFURA_PROJECT_ID="your_infura_project_id"
```
```
$brownie run scripts/deploy.py --network goerli
```

# Interact with the deployed smart-contract

The script [](./scripts/fund_withdraw.py) funds the smart-contract with a small ammount and then withdraws it.

```
$brownie run scripts/fund_withdraw.py --network goerli
```