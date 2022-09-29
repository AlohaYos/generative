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

### Deployment
```
npx hardhat run ./scripts/deploy_splatter.ts
・deploy_splatter.ts を "--network goerli" オプション付きで走らせる
・splatter_goerli.ts というファイルが contract/cache に生成される
・それを utils/addresses にコピー
```

### 手動デプロイ手順
```
1. Vue/TypeScriptサービスを起動
cd generative
yarn run serve

2. RemixIDEをローカルフォルダに繋ぐ
remixd -s ./generative/ -u https://remix.ethereum.org/

3. RemixIDEでsplatter.tsを編集して図形を作る
　・確認 http://localhost:8080/splatter
4. RemixIDEでSplatterProvider.solに移植する
5. goerliテストネットワークに以下の順にデプロイする（上記Deploymentの手動版）
　・SplatterProvider.sol
　・SplatterArtProvider.sol
　・SplatterToken.sol
6. テスト用OpenSeaにミントする
　・Mintボタン： http://localhost:8080/splatterYos
```

### デプロイに必要な情報
```
SplatterProviderのデプロイに必要なもの
・特になし

SplatterArtProviderのデプロイに必要なもの
・SplatterProvider

SplatterTokenのデプロイに必要なもの
・SplatterArtProvider
・Account（MetaMaskアドレス）
・テストOpenSea Proxy（0xa5409ec958c83c3f309868babaca7c86dcb077c1）

これらを設定して以下の順にデプロイする。
・SplatterProvider.sol
・SplatterArtProvider.sol
・SplatterToken.sol

デプロイ完了したアドレスを
util/addresses/splatter_goerli.tsにコピーする。
```
