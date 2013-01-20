#### class `Ball`

Object to be created with variable weight.

**Initialize** using `new(w)`

*parameter* `w`<br>
Weight of this ball.<br>
Default value = `5`.

**class var** `@@id`

   Holds the value of the ID for the next ball created.

**inst var** `@id` - Accessor methods available.

ID number for this ball.

**inst var** `@weight` - Accessor methods available.

Weight of this ball.

**class method** `self.defaultWeight`

Returns the default weight of a Ball object.

**class method** `self.resetId`

Resets the ID counter to 1.<br>
*Recommended use*: Call before each new set of balls is created.

