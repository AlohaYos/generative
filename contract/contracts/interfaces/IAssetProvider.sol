// SPDX-License-Identifier: MIT

/**
 * This is a part of an effort to create a decentralized autonomous marketplace for digital assets,
 * which allows artists and developers to sell their arts and generative arts.
 *
 * Please see "https://fullyonchain.xyz/" for details. 
 *
 * Created by Satoshi Nakajima (@snakajima)
 */
pragma solidity ^0.8.6;

/**
 * IAssetProvider is the interface each asset provider implements.
 * We assume there are three types of asset providers.
 * 1. Static asset provider, which has a collection of assets (either in the storage or the code) and returns them.
 * 2. Generative provider, which dynamically (but deterministically from the seed) generates assets.
 * 3. Data visualizer, which generates assets based on various data on the blockchain.
 *
 * Note: Asset providers MUST implements IERC165 (supportsInterface method) as well. 
 */
interface IAssetProvider {
  struct ProviderInfo {
    string key;  // short and unique identifier of this provider (e.g., "asset")
    string name; // human readable display name (e.g., "Asset Store")
    IAssetProvider provider;
  }
  function getProviderInfo() external view returns(ProviderInfo memory);

  /**
   * This function returns SVGPart and the tag. The SVGPart consists of one or more SVG elements.
   * The tag specifies the identifier of the SVG element to be displayed (using <use> tag).
   * The tag is the combination of the provider key and assetId (e.e., "asset123")
   */
  function generateSVGPart(uint256 _assetId) external view returns(string memory svgPart, string memory tag);

  /**
   * This function returns the number of assets available from this provider. 
   * If the total supply is 100, assetIds of available assets are 0,1,...99.
   * The generative providers may returns 0, which indicates the provider dynamically but
   * deterministically generates assets using the given assetId as the random seed.
   */
  function totalSupply() external view returns(uint256);

  /**
   * Returns the onwer. The registration update is possible only if both contracts have the same owner. 
   */
  function getOwner() external view returns (address);

  /**
   * This function processes the royalty payment from the decentralized autonomous marketplace. 
   */
  function processPayout(uint256 _assetId) external payable;

  event Payout(string providerKey, uint256 assetId, address payable to, uint256 amount);
}

/**
 * This is an extended interface of IAssetProvider for those providers,
 * which offers categorized assets, such as AssetStoreProvider. 
 */
interface ICategorizedAssetProvider is IAssetProvider {
  function getGroupCount() external view returns(uint32);
  function getGroupNameAtIndex(uint32 _groupIndex) external view returns(string memory);
  function getCategoryCount(string memory _group) external view returns(uint32);
  function getCategoryNameAtIndex(string memory _group, uint32 _categoryIndex) external view returns(string memory);
  function getAssetCountInCategory(string memory _group, string memory _category) external view returns(uint32);
  function getAssetIdInCategory(string memory _group, string memory _category, uint32 _assetIndex) external view returns(uint256);
}