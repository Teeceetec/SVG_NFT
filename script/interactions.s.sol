//SPDX-License-Identifier:MIT
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant PUG_URI = "";

   function run () external {

    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);

    mintNFTOnConract(mostRecentlyDeployed);
   }

    function mintNFTOnContract (address contractAddress) public {
      vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG_URI);
      vm.stopBroadcast();
    }
}

 contract MintMoodNft is Script {
    
    function run() external {
      address mostRecentlyDeployedBasicNft = DEvOpsTools.get_most_recent_deployment("MoodNft", block.chainId);

      mintNftContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftContract ( address contractaddress) public {
      vm.startBroadcast(contractaddress);
      MoodNft(contractaddress).mintNft();
      vm.stopBroadcast();
    }
 }

 contract flipMoodNft is Script {
    
    uint256 public constant TOKEN_ID_TO_FLIP = 0;
   
   function run () external {
    address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedBasicNft);

   }

    function flipMoodNft(address contractaddress) public {
        vm.startBroadcast();
        MoodNft(contractaddress).flipMoodNft(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
       
    }
 }