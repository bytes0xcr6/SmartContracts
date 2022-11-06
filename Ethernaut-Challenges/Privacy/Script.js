const Web3 = require("web3");
const web3 = new Web3("https://polygon-mumbai.g.alchemy.com/v2/<API KEY>");

const contract = "<Contract address>";

// It will return the slot 5th, which is the last position in the data array
web3.eth.getStorageAt(contract, 5, (err, result) => {
    console.log(result);
})
