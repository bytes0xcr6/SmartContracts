# Elevatro Challenge

![BigLevel11](https://user-images.githubusercontent.com/102038261/200005950-ecf79f46-5253-4dcc-ab27-3ac462346363.svg)

<h3> Instructions from Ethernaut</h3>

This elevator won't let you reach the top of your building. Right?

Things that might help:
* Sometimes solidity is not good at keeping promises.
* This Elevator expects to be used from a Building.

<h3>To solve the challenge we need to... </h3>

<p>Fill out the Interface function that the "Elevator" contract is calling, as it is missing the function content. We just need to set the interface function to swtich a boolean value to its oposite value once the function has been called. (Example: True => False, False => True)

As the function "goTo" from the contract "Elevator" calls the interface function twice and it needs a false value and then a true value. When it calls for the first time, it will get a false value and when it calls for the second time the interface function, it will return true value.</p>
