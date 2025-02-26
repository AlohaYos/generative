// SPDX-License-Identifier: MIT

/*
 * NounsAssetProvider is a wrapper around NounsDescriptor so that it offers
 * various characters as assets to compose (not individual parts).
 *
 * Created by Satoshi Nakajima (@snakajima)
 */

pragma solidity ^0.8.6;

import { Ownable } from '@openzeppelin/contracts/access/Ownable.sol';
import { IAssetProvider } from './interfaces/IAssetProvider.sol';
import { ISVGHelper } from './interfaces/ISVGHelper.sol';
import './libs/Trigonometry.sol';
import './libs/Randomizer.sol';
import './libs/SVGHelper.sol';
import "@openzeppelin/contracts/utils/Strings.sol";
import '@openzeppelin/contracts/interfaces/IERC165.sol';
import "hardhat/console.sol";

contract SplatterProvider is IAssetProvider, IERC165, Ownable {
  using Strings for uint32;
  using Strings for uint256;
  using Randomizer for Randomizer.Seed;
  using Trigonometry for uint;

  struct Props {
    uint count; // number of control points
    uint length; // average length fo arm
    uint dot; // average size of dot
  }

  string constant providerKey = "splt";
  address public receiver;
  ISVGHelper svgHelper;

  constructor() {
    receiver = owner();
    svgHelper = new SVGHelper(); // default helper
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return
      interfaceId == type(IAssetProvider).interfaceId ||
      interfaceId == type(IERC165).interfaceId;
  }

  function getOwner() external override view returns (address) {
    return owner();
  }

  function getProviderInfo() external view override returns(ProviderInfo memory) {
    return ProviderInfo(providerKey, "Splatter", this);
  }

  function totalSupply() external pure override returns(uint256) {
    return 0; // indicating "dynamically (but deterministically) generated from the given assetId)
  }

  function processPayout(uint256 _assetId) external override payable {
    address payable payableTo = payable(receiver);
    payableTo.transfer(msg.value);
    emit Payout(providerKey, _assetId, payableTo, msg.value);
  }

  function setReceiver(address _receiver) onlyOwner external {
    receiver = _receiver;
  }

  function setHelper(ISVGHelper _svgHelper) external onlyOwner {
    svgHelper = _svgHelper;
  }

/// Propsの中にcount, length, dotが詰まっている
  function generatePoints(Randomizer.Seed memory _seed, Props memory _props) pure internal returns(Randomizer.Seed memory, ISVGHelper.Point[] memory) {

    Randomizer.Seed memory seed = _seed;
    uint count;
    (seed, count) = seed.randomize(100, 90);
    ISVGHelper.Point[] memory points = new ISVGHelper.Point[](count  + count /3 * 5);

    uint r0 = 300;
    int32 rto = 1024;
    uint j = 0;

    for (uint i = 0; i < count; i++) {
      uint xx;
      uint yy;
      uint cc;
      (seed, xx) = seed.randomize(r0, 100);
      (seed, yy) = seed.randomize(r0, 100);
      (seed, cc) = seed.randomize( 2, 100);
      bool tf = true;
      if(cc>0) tf = false;

      points[j].x = int32(int(xx));
      points[j].y = int32(int(yy));
      points[j].c = tf;
      points[j].r = rto;
      j++;
    }
    return (seed, points);


/*  
    ISVGHelper.Point[] memory points = new ISVGHelper.Point[](_props.count  + _props.count /3 * 5);
    Randomizer.Seed memory seed = _seed;
    uint[] memory degrees = new uint[](_props.count);
    uint total;
    for (uint i = 0; i < _props.count; i++) {
      uint degree;
      (seed, degree) = seed.randomize(100, 90);
      degrees[i] = total;
      total += degree;
    }

    uint r0 = 220;
    uint r1 = r0;
    uint j = 0;
    for (uint i = 0; i < _props.count; i++) {
      {
        uint angle = degrees[i] * 0x4000 / total + 0x4000;
        if (i % 3 == 0) {
          uint extra;
          (seed, extra) = seed.randomize(_props.length, 100);
          uint arc;
          (seed, arc) = seed.randomize(_props.dot, 50); 

          points[j].x = int32(512 + (angle - 30).cos() * int(r1) / 0x8000);
          points[j].y = int32(512 + (angle - 30).sin() * int(r1) / 0x8000);
          points[j].c = false;
          points[j].r = 1024;
          j++;
          points[j].x = int32(512 + (angle - 30).cos() * int(r1 + extra) / 0x8000);
          points[j].y = int32(512 + (angle - 30).sin() * int(r1 + extra) / 0x8000);
          points[j].c = false;
          points[j].r = 566;
          j++;
          points[j].x = int32(512 + (angle - arc).cos() * int(r1 + extra * (150 + arc) / 150) / 0x8000);
          points[j].y = int32(512 + (angle - arc).sin() * int(r1 + extra * (150 + arc) / 150)  / 0x8000);
          points[j].c = false;
          points[j].r = 566;
          j++;
          points[j].x = int32(512 + (angle + arc).cos() * int(r1 + extra * (150 + arc) / 150)  / 0x8000);
          points[j].y = int32(512 + (angle + arc).sin() * int(r1 + extra * (150 + arc) / 150)  / 0x8000);
          points[j].c = false;
          points[j].r = 566;
          j++;
          points[j].x = int32(512 + (angle + 30).cos() * int(r1 + extra) / 0x8000);
          points[j].y = int32(512 + (angle + 30).sin() * int(r1 + extra) / 0x8000);
          points[j].c = false;
          points[j].r = 566;
          j++;
          points[j].x = int32(512 + (angle + 30).cos() * int(r1) / 0x8000);
          points[j].y = int32(512 + (angle + 30).sin() * int(r1) / 0x8000);
          points[j].c = false;
          points[j].r = 1024;
          j++;
        } else {
          points[j].x = int32(512 + angle.cos() * int(r1) / 0x8000);
          points[j].y = int32(512 + angle.sin() * int(r1) / 0x8000);
          points[j].c = false;
          points[j].r = 566;
          j++;
        }
      }
      {
        uint r2;
        (seed, r2) = seed.randomize(r1, 20);
        r1 = (r2 * 2 + r0) / 3;
      }
    }
    return (seed, points);
*/  
  }

  function generatePath(Randomizer.Seed memory _seed, Props memory _props) public view returns(Randomizer.Seed memory seed, bytes memory svgPart) {
    ISVGHelper.Point[] memory points;
    (seed, points) = generatePoints(_seed, _props);
    svgPart = svgHelper.PathFromPoints(points);
  }

  function generateProps(Randomizer.Seed memory _seed) public pure returns(Randomizer.Seed memory seed, Props memory props) {
    seed = _seed;
    props = Props(30, 40, 100);
    (seed, props.count) = seed.randomize(props.count, 50); // +/- 50%
    (seed, props.length) = seed.randomize(props.length, 50); // +/- 50%
    (seed, props.dot) = seed.randomize(props.dot, 50);
    props.count = props.count / 3 * 3; // always multiple of 3
  }

  function generateSVGPart(uint256 _assetId) external view override returns(string memory svgPart, string memory tag) {
    Randomizer.Seed memory seed = Randomizer.Seed(_assetId, 0);
    Props memory props;
    (seed, props) = generateProps(seed);

    bytes memory path;
    (,path) = generatePath(seed, props);

    tag = string(abi.encodePacked(providerKey, _assetId.toString()));
    svgPart = string(abi.encodePacked(
      '<g id="', tag, '">\n'
      '<path d="', path, '"/>\n'
      '</g>\n'
    ));
  }
}