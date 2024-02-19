// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ByteHasher} from "./helpers/ByteHasher.sol";
import {IWorldID} from "./interfaces/IWorldID.sol";

contract SolanaWalletMgr {
    using ByteHasher for bytes;

    // thrown when a nullifier is reused
    error InvalidNullifier();

    // the WorldId instance used for proof verification
    IWorldID internal immutable worldId;

    // contracts external nullifier hash
    uint256 internal immutable externalNullifier;

    // the world id group id (always 1)
    // 1 == must be orb verified
    uint256 internal immutable groupId = 1;

    // track nullifier hashes
    mapping(uint256 => bool) internal nullifierHashes;

    constructor(IWorldID _worldId, string memory _appId, string memory _actionId) {
        worldId = _worldId;
        externalNullifier = abi.encodePacked(abi.encodePacked(_appId).hashToField(), _actionId).hashToField();
    }

    // basic claim airdrop
    function setWallet(address signal, uint256 root, uint256 nullifierHash, uint256[8] calldata proof) public {
        // check nullifier hash hasnt been used
        if (nullifierHashes[nullifierHash]) revert InvalidNullifier();

        // verify the proof is valid and the user is verified by World Id
        worldId.verifyProof(
            root, groupId, abi.encodePacked(signal).hashToField(), nullifierHash, externalNullifier, proof
        );

        // record user has done action
        nullifierHashes[nullifierHash] = true;
    }
}
