// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;

    address public USER = makeAddr("user");
     bytes public constant PUG_URI = "";


    function setUp() public {
        deployer = new DeployBasicNft();
         basicNft = deployer.run();
    }
  
   function testNameIsCorrect() public view {
    string memory expectedName = "TEG";
    string memory actualName = basicNft.name();

    assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
   }
   

   function testCanMintAndHaveBalance() public {
     vm.prank(USER);

      basicNft.mint(PUG_URI);
      assert(basicNft.balanceOf(USER) == 1);
   }

   
}
