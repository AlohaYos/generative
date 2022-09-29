# Generative

## Rrequirements

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

### TypeScript and Solidity
```
1. RemixIDEをローカルフォルダに繋ぐ
　　・remixd -s ./generative/ -u https://remix.ethereum.org/
  　・RemixIDEのFILE EXPLORERでlocalhostを選ぶ
2. RemixIDEでsrc/generative/splatter.tsを編集して図形を作る
　　・確認 http://localhost:8080/splatter
3. RemixIDEでcontract/contructs/SplatterProvider.solに移植する
　　・ビルドエラー確認のみ。IDEでは動作は確認できない。
```

## Deployment

### Deploy Script
```
npx hardhat run ./scripts/deploy_splatter.ts
・deploy_splatter.ts を "--network goerli" オプション付きで走らせる
・splatter_goerli.ts というファイルが contract/cache に生成される
・それを utils/addresses にコピー
```

### 手動デプロイ手順（deploy_splatter.tsがエラーの時など）
```
1. goerliテストネットワークに以下の順にデプロイする（上記Deploy Scriptを手動で行う）
　・SplatterProvider.sol
　　　　SplatterProviderのデプロイに必要なもの
　　　　　・特になし
　・SplatterArtProvider.sol
　　　　SplatterArtProviderのデプロイに必要なもの
　　　　　・SplatterProviderアドレス
　・SplatterToken.sol
　　　　SplatterTokenのデプロイに必要なもの
　　　　　・SplatterArtProviderアドレス
　　　　　・Account（MetaMaskアドレス）
　　　　　・テストOpenSea Proxy（0xa5409ec958c83c3f309868babaca7c86dcb077c1）
2. デプロイ完了したコントラクトアドレスを
　・util/addresses/splatter_goerli.tsにコピーする。
　　　 export const addresses = {
　　　　  splatterAddress:"0x967466...",
　　　　  splatterArtAddress:"0xD9EeC3...",
　　　　  splatterToken:"0xaBA061..."
　　　}
```

## Mint

### Mint to OpenSea(testnet)
```
1. テスト用OpenSeaにミントする
　・Mintボタン： http://localhost:8080/splatterYos
```
