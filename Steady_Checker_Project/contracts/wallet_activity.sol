// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WalletActivity {
    struct Proof {
        bytes32 root;
        uint256 blockNumber;
        uint256 timestamp;
    }

    mapping(address => Proof[]) private proofs;

    function storeProof(bytes32 root, uint256 blockNumber, uint256 timestamp) external {
        proofs[msg.sender].push(Proof(root, blockNumber, timestamp));
    }

    function getProofCount(address wallet) external view returns (uint256) {
        return proofs[wallet].length;
    }

    function verifyProof(bytes32 root, uint256 blockNumber, uint256 timestamp) external view returns (bool) {
        Proof[] memory walletProofs = proofs[msg.sender];
        for (uint256 i = 0; i < walletProofs.length; i++) {
            if (walletProofs[i].root == root && walletProofs[i].blockNumber == blockNumber && walletProofs[i].timestamp == timestamp) {
                return true;
            }
        }
        return false;
    }

    function getProofAtIndex(address wallet, uint256 index) external view returns (bytes32, uint256, uint256) {
        require(index < proofs[wallet].length, "Index out of range");
        Proof memory proof = proofs[wallet][index];
        return (proof.root, proof.blockNumber, proof.timestamp);
    }

    function getTotalProofs() external view returns (uint256) {
        uint256 totalProofs;
        for (uint256 i = 0; i < proofs[msg.sender].length; i++) {
            totalProofs += proofs[msg.sender][i].blockNumber;
        }
        return totalProofs;
    }
}
