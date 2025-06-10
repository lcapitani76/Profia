// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FileCertifier {
    struct FileProof {
        address sender;
        string description;
        uint256 timestamp;
    }

    mapping(bytes32 => FileProof) public proofs;

    event FileRegistered(
        bytes32 indexed fileHash,
        address indexed sender,
        string description,
        uint256 timestamp
    );

    function registerFile(bytes32 fileHash, string memory description) public {
        require(proofs[fileHash].timestamp == 0, "File already registered");
        proofs[fileHash] = FileProof({
            sender: msg.sender,
            description: description,
            timestamp: block.timestamp
        });
        emit FileRegistered(fileHash, msg.sender, description, block.timestamp);
    }

    function getProof(bytes32 fileHash)
        public
        view
        returns (address sender, string memory description, uint256 timestamp)
    {
        FileProof memory fp = proofs[fileHash];
        return (fp.sender, fp.description, fp.timestamp);
    }
}
