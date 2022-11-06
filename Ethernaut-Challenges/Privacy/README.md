# Privacy challenge

![BigLevel12](https://user-images.githubusercontent.com/102038261/200168738-34847279-5102-4e77-839b-f7f53e8fad25.svg)

<h3> Instructions from Ethernaut</h3>

The creator of this contract was careful enough to protect the sensitive areas of its storage.

Unlock this contract to beat the level.

Things that might help:

* Understanding how storage works
* Understanding how parameter parsing works
* Understanding how casting works

Tips:

* Remember that metamask is just a commodity. 
* Use another tool if it is presenting problems. 
* Advanced gameplay could involve using remix, or your own web3 provider.

<h3>To solve the challenge we need to... </h3>

<p>Check in which Storage Slot position is the variable we are looking for, we can get it from the console with:</p> 

```
web3.eth.getStorageAt(<contract.address>, <slot position>, (err, result) => {console.log(result)};
```

<p> or we can use the Script I created to ask a Node for the information. Then, we call the contract function "unlock" and we pass the bytes32 to to unlock it. Do not forget that the parameter the unlock function is waiting is a bytes16, so we need to pass it to bytes16 as in the example.</p>
