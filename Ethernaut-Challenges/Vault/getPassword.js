// I created this script to request the info from a Blockchain Node. I used Alchemy.

const Web3 = require("web3");
const web3 = new Web3(
  "https://polygon-mumbai.g.alchemy.com/v2/<YOUR API KEY>"
);

const contract = "<SMART CONTRACT ADDRESS>";

web3.eth.getStorageAt(contract, 1, (err, result) => {
  console.log("The result in bytes is:", result);
  console.log("The result in String is:", web3.utils.toUtf8(result));
});
