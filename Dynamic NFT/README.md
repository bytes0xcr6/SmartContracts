# Dynamic NFTs using Chainlink VRF (Verified Random Number)

This is a Dynamic NFT project where the NFT can change with time. It has 3 stages:

- Car
- Sport Car
- Transformer

I am using Infura to upload the images and the metadata to IPFS. Following <a href="https://docs.opensea.io/docs/metadata-standards">Metadata Standars from Open Sea</a>.

Also, I am subscribing to <a href="https://vrf.chain.link/">Chainlink VRF</a> to get a random number for the NFT mint.

1. Subscribe to VRF adding LINK.
2. Adjust the subscription details in the Smart contract. (Key hash and VRF Coordinator)
3. Add consumer address (Contract address) to allow request random numbers.
4. Start requestin VRF.
