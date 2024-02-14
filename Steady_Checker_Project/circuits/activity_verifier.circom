// activity_verifier.circom - Steady Checker Activity Verifier Circuit 🕵️‍♂️🔍

include "merkle_tree.circom";

// Constants
const NUM_LEAVES = 32;
const HASH_CHAIN_LEN = 5;

// Inputs
signal leaf[NUM_LEAVES][HASH_CHAIN_LEN] = input;
signal root = input;

// Merkle tree verification
component merkleTree = MerkleTree(NUM_LEAVES, HASH_CHAIN_LEN);
merkleTree.rootHash <== root;
merkleTree.leafHashes <== leaf;

// Main Circuit
template main() {
    signal index = public(5);
    signal hash_chain = private(HASH_CHAIN_LEN);

    hash_chain[0] <== 123456; // Initial hash value

    for (var i = 1; i < HASH_CHAIN_LEN; i++) {
        hash_chain[i] <== sha256(hash_chain[i - 1]);
    }

    // Check if the calculated root matches the provided root
    assert(merkleTree.verifyPath(hash_chain, index), "Invalid root hash provided!");
}

// Run the main circuit
component main();
