// Steady Checker Wallet Checker - Rust Version
use std::collections::HashMap;

// Define struct to store proofs
struct Proof {
    root: String,
    block_number: u64,
    timestamp: u64,
}

// Define WalletChecker struct
pub struct WalletChecker {
    proofs: HashMap<String, Vec<Proof>>, // Mapping to store proofs for each wallet address
}

impl WalletChecker {
    // Constructor
    pub fn new() -> Self {
        WalletChecker {
            proofs: HashMap::new(),
        }
    }

    // Function to store proof for a wallet address
    pub fn store_proof(&mut self, wallet_address: String, root: String, block_number: u64, timestamp: u64) {
        let proof = Proof {
            root,
            block_number,
            timestamp,
        };

        self.proofs.entry(wallet_address).or_insert(Vec::new()).push(proof);
    }

    // Function to verify proof for a wallet address
    pub fn verify_proof(&self, wallet_address: &str, root: &str, block_number: u64, timestamp: u64) -> bool {
        if let Some(proofs) = self.proofs.get(wallet_address) {
            for proof in proofs {
                if proof.root == root && proof.block_number == block_number && proof.timestamp == timestamp {
                    return true;
                }
            }
        }
        false
    }

    // Function to get total proofs stored for a wallet address
    pub fn get_total_proofs(&self, wallet_address: &str) -> usize {
        if let Some(proofs) = self.proofs.get(wallet_address) {
            proofs.len()
        } else {
            0
        }
    }

    // Function to get total proofs stored for all wallet addresses
    pub fn get_total_all_proofs(&self) -> usize {
        let mut total_proofs = 0;
        for proofs in self.proofs.values() {
            total_proofs += proofs.len();
        }
        total_proofs
    }

}
