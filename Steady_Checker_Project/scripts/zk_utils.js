// zk_utils.js - Zero-Knowledge Utilities for Steady Checker

// Define a struct to represent a zero-knowledge proof
class Proof {
    constructor(root, blockNumber, timestamp) {
        this.root = root;
        this.blockNumber = blockNumber;
        this.timestamp = timestamp;
    }
}

// Mapping to store proofs for each wallet address
let proofs = {};

// Function to store a proof for a wallet address
function storeProof(wallet, root, blockNumber, timestamp) {
    if (!proofs[wallet]) {
        proofs[wallet] = [];
    }
    proofs[wallet].push(new Proof(root, blockNumber, timestamp));
}

// Function to get the total number of proofs for a wallet address
function getProofCount(wallet) {
    return proofs[wallet] ? proofs[wallet].length : 0;
}

// Function to verify a proof for a wallet address
function verifyProof(wallet, root, blockNumber, timestamp) {
    if (!proofs[wallet]) {
        return false;
    }
    return proofs[wallet].some((proof) => proof.root === root && proof.blockNumber === blockNumber && proof.timestamp === timestamp);
}


// Function to get the total sum of block numbers in proofs for a wallet address
function getTotalProofs(wallet) {
    return proofs[wallet] ? proofs[wallet].reduce((total, proof) => total + proof.blockNumber, 0) : 0;
}

// Export the functions for external use
module.exports = {
    storeProof,
    getProofCount,
    verifyProof,
    getTotalProofs
};
