// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.25;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract BasicNft is ERC721 , Ownable{
  /**Errors */
   error ERC721Metadata__URI_QueryFor_NonExistenToken();
   error MoodNft__CantFlipMoodIfNotOwner();

   /**Type data */
   enum NFTState {
      HAPPY,
      SAD
   }

   mapping(uint256 => NFTState) private s_tokenIdToState;

  /**URI */
  string private s_sadSvgUri;
  string private s_happySvgUri;

  /** ID */
  uint256 private s_tokenCounter;

  constructor (string memory sadSvgUri, string memory happySvgUri ) ERC721{"MOOD NFT", "MN"} {
     s_sadSvgUri =  sadSvgUri;
     s_happySvgUri = happySvgUri;
     tokenCounter = 0;
  }

 function mintNft() public {
  uint256 tokenCounter = s_tokenCounter;
   _safeMint(msg.sender, tokenCounter);
   s_tokenCounter = s_tokenCounter + 1;
   emit CreatedNft(tokenCounter);

 }

 function flipMood(uint256 tokenId) public {
     if(getApproved(tokenId) !== msg.sender && ownerOf(tokenId) !== msg.sender) {
      revert MoodNft__CantFlipMoodIfNotOwner();
     }

     if(s_tokenIdToState[tokenId] == NFTState.HAPPY) {
        s_tokenIdToState[tokenId] = NFTState.SAD;
     } else {
       s_tokenIdToState[tokenId] = NFTState.HAPPY;
     }
 }
  
  function baseURI() public view ovverride returns(string memory) {
    return "data:application/json;base64";
  }

  function tokenURI(uint256 _tokenId) public view override returns(string memory) {
    if(ownerOf(_tokenId) == address(0)) {
      revert ERC721Metadata__URI_QueryFor_NonExistenToken();
    }

      string memory imageURI;

      if (s_tokenIdToState[_tokenId] == NFTState.HAPPY) {
        imageURI = s_happySvgUri;
      } else {
        imageURI = s_sadSvgUri;
      }

      return 
         string (
             abi.encodePacked(
                 _baseURI(),
                 Base64.encode(
                      bytes(
                          abi.encodePacked(
                               '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                          )
                      )
                 )
             )
         );
  }


   /**Getters Function */

    function getHappySVG() public view returns(string memory) {
       return s_happySvgUri;
    }

    function getSadSVG public view returns(string memory) {
       return s_sadSvgUri
    }
     function getTokenCounter() public view returns(uint256) [
       return s_tokenCounter;
     ]
}