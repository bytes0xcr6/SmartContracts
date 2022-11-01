const MultiSigWallet = artifacts.require("MultiSigWallet");

/*
Testing accounts Ganache
Account 0 (Deployer): 0x627306090abaB3A6e1400e9345bC60c78a8BEf57
Account 1: 0xf17f52151EbEF6C7334FAD080c5704D77216b732
Account 2: 0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef
Account 3: 0x821aEa9a577a9b44299B9c15c88cf3087F3b5544
*/

module.exports = function (deployer) {
  deployer.deploy(
    MultiSigWallet,
    [
      "0x627306090abaB3A6e1400e9345bC60c78a8BEf57",
      "0xf17f52151EbEF6C7334FAD080c5704D77216b732",
      "0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef",
    ],
    3
  );
};
