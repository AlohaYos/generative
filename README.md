# Generative

## Requirements

- Node.js: version 14 or later.
- yarn: version 1.22.19

## Frontend - Vue/Typescript

### Installation & Initialization

```
git clone git@github.com:Cryptocoders-wtf/generative.git
cd generative
yarn install
```
### Serving
```
yarn run serve
```
### Running
open http://localhost:8080

## Backend - Solidity

### Initialization

```
cd contract
npm install
```

## Coding

### RemixIDE
Connect RemixIDE to local folder.
```
remixd -s ./generative/ -u https://remix.ethereum.org/
```
Select "localhost" at FILE EXPLORER of RemixIDE workspace.

### TypeScript
- Edit src/generative/splatter.ts in order to design generative arts.
- Check it at http://localhost:8080/splatter

### Solidity
- Port splatter.ts into contract/contructs/SplatterProvider.sol
- Compile check only. SplatterProvider.sol does not work on RemixIDE.

## Deployment

### Deploy Script
```
npx hardhat run ./scripts/deploy_splatter.ts --network goerli
```
- splatter_goerli.ts will be created in contract/cache folder.
- Copy splatter_goerli.ts into utils/addresses folder.

### Manual deploy（in case deploy_splatter.ts got error）
1. Select "Injected Provider - Metamask" at "ENVIRONMENT" selector of Deploy pane.
2. Connect "ACCOUNT" to developer's Metamask.
3. Select each "CONTRACT" and deploy *.sol to goerli test network manually as below.
- SplatterProvider.sol
  - args :
    - nothing
- SplatterArtProvider.sol
  - args :
    - SplatterProvider address
- SplatterToken.sol
  - args :
    - SplatterArtProvider address
    - Account address（MetaMask address）
    - OpenSea testnet Proxy（0xa5409ec958c83c3f309868babaca7c86dcb077c1）
4. Copy these three contract addresses into util/addresses/splatter_goerli.ts as below. Each contract address will be displayed at "Deployed Contracts" section at the bottom of Deploy pane.
```
export const addresses = {
  splatterAddress:"0x967466...",
  splatterArtAddress:"0xD9EeC3...",
  splatterToken:"0xaBA061..."
}
```

## Mint

### Mint to OpenSea(testnet)
Mint to OpenSea testnet
- Mint button： http://localhost:8080/splatter

## Check result

### OpenSea(testnet)
- Open https://testnets.opensea.io/
- Input Account address（MetaMask address）into search box.
- Click the item.
- Open "Details" pulldown and check:
  - Contract Address (which is the address of SplatterToken contract)
  - Token ID
  - Blockchain (Goerli)
  - Last Updated (the time item was created)
