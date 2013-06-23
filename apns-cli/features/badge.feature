Feature: Push Notification Badge

	The badge key in the push notification payload sets a badge on the receiving app.

	The number on the badge is specified by the value paired with the badge key in the notification's payload.

	Background:

		Given I am sending a notification to oletha

	Scenario Outline: Use the badge option

		Given I specify a badge of <number>
		When I send the command
		Then the badge is set to <number> in the notification payload

		Examples:

			| number	|
			| 1			|
			| 0			|
			| 5			|
			| 29056		|

	Scenario: Do not use the badge option

		Given I do not use the badge option
		When I send the command
		Then the badge is not set in the notification payload

	Scenario Outline: Invalid parameter sent for badge option

		Given I specify a badge of <invalid_data>
		When I send the command
		Then an error is raised

		Examples:

			| invalid_data	|
			| string		|
			| a1ph4num		|
			| :symbol		|
			| [array]		|
			| {key=>val}	|
			| 1 3			|
			| -4			|
			| !)$£*			|

	Scenario: No parameter sent for badge option
		This could include a check for an appropriate error message in future iterations.

		Given I include the badge option in my command
		But I do not specify a parameter for the badge option
		When I send the command
		Then an error is raised

	Scenario: Short version of badge option used
		Sending -b is the short version of sending --badge.
		This should not conflict with any other options.

		Given I specify a badge of 1
		And I use the short version of the badge command
		When I send the command
		Then the badge is set to 1 in the notification payload