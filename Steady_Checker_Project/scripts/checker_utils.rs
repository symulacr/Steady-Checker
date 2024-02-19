// Steady Checker - Crypto Audit Tool
// checker_utils.rs

use std::collections::HashMap;

pub struct Proof {
    pub root: String,
    pub block_number: u64,
    pub timestamp: u64,
}

pub struct CheckerUtils {
    proofs: HashMap<String, Vec<Proof>>,
}

impl CheckerUtils {
    pub fn new() -> Self {
        CheckerUtils {
            proofs: HashMap::new(),
        }
    }

    pub fn store_proof(&mut self, wallet_address: &str, root: String, block_number: u64, timestamp: u64) {
        let proof = Proof {
            root,
            block_number,
            timestamp,
        };

        let proofs = self.proofs.entry(wallet_address.to_string()).or_insert(Vec::new());
        proofs.push(proof);
    }

    pub fn get_proof_count(&self, wallet_address: &str) -> usize {
        self.proofs.get(wallet_address).map_or(0, |proofs| proofs.len())
    }

    pub fn verify_proof(&self, wallet_address: &str, root: &str, block_number: u64, timestamp: u64) -> bool {
        if let Some(proofs) = self.proofs.get(wallet_address) {
            for proof in proofs {
                if proof.root == *root && proof.block_number == block_number && proof.timestamp == timestamp {
                    return true;
                }
            }
        }
        false
    }

   
    pub fn get_total_proofs(&self, wallet_address: &str) -> u64 {
        if let Some(proofs) = self.proofs.get(wallet_address) {
            proofs.iter().map(|proof| proof.block_number).sum()
        } else {
            0
        }
    }

}
