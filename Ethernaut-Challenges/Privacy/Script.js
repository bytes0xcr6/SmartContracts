const Web3 = require("web3");
const web3 = new Web3("https://polygon-mumbai.g.alchemy.com/v2/qyfgNG7RUCVvgv2yPnYwVzxfjFf0-cl7");

const contract = "0x77aF4957D46ac0f2163CF3c9097A6c2EbD61A5f7";

// It will return the slot 5th, which is the last position in the data array
web3.eth.getStorageAt(contract, 5, (err, result) => {
    console.log(result);
})
