// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WalletCheckerContract {
    struct WalletProof {
        bytes32 root;
        uint256 blockNumber;
        uint256 timestamp;
        bool verified;
    }

    mapping(address => WalletProof[]) private walletProofs;

    function storeProof(bytes32 root, uint256 blockNumber, uint256 timestamp) external {
        walletProofs[msg.sender].push(WalletProof(root, blockNumber, timestamp, false));
    }

    function verifyProof(uint256 index) external {
        require(index < walletProofs[msg.sender].length, "Index out of range");
        WalletProof storage proof = walletProofs[msg.sender][index];
        require(!proof.verified, "Proof already verified");

        // Perform zero-knowledge proof verification logic here

        proof.verified = true;
    }

    function getProofCount(address wallet) external view returns (uint256) {
        return walletProofs[wallet].length;
    }

    function getProofAtIndex(address wallet, uint256 index) external view returns (bytes32, uint256, uint256, bool) {
        require(index < walletProofs[wallet].length, "Index out of range");
        WalletProof memory proof = walletProofs[wallet][index];
        return (proof.root, proof.blockNumber, proof.timestamp, proof.verified);
    }

    function getTotalProofs() external view returns (uint256) {
        uint256 totalProofs;
        for (uint256 i = 0; i < walletProofs[msg.sender].length; i++) {
            totalProofs += walletProofs[msg.sender][i].blockNumber;
        }
        return totalProofs;
    }

    function getProofStatus(address wallet, uint256 index) external view returns (bool) {
        require(index < walletProofs[wallet].length, "Index out of range");
        return walletProofs[wallet][index].verified;
    }

    function getLatestProof(address wallet) external view returns (bytes32, uint256, uint256, bool) {
        uint256 index = walletProofs[wallet].length - 1;
        WalletProof memory proof = walletProofs[wallet][index];
        return (proof.root, proof.blockNumber, proof.timestamp, proof.verified);
    }

 }
