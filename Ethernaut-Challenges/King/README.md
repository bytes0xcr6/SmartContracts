# King Challenge

![BigLevel9](https://user-images.githubusercontent.com/102038261/199809453-43ed28bd-0dcd-4d99-ad7f-9ab65635824e.svg)

<h3> Instructions from Ethernaut</h3>

<p>The contract below represents a very simple game: whoever sends it an amount of ether that is larger than the current prize becomes the new king. On such an event, the overthrown king gets paid the new prize, making a bit of ether in the process! As ponzi as it gets xD

Such a fun game. Your goal is to break it.

When you submit the instance back to the level, the level is going to reclaim kingship. You will beat the level if you can avoid such a self proclamation.</p>

<h3>To solve the challenge we need to... </h3>

<p>Create a malicious Smart Contract, where we will set the "fallback function" with a "revert" as default. We just need to send more "Prize" than the previous King to become the King and it will trigger the transfer function from the "King" contract. It will never send the ethers to the new King address (Malicious contract address), as the fallback function will keep reverting the transfer. So it is GAME OVER!</p>
