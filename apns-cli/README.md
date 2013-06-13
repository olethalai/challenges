# PushIt

PushIt is a command line interface for sending push notifications using [Houston](https://github.com/nomad/houston/).

In addition to the regular push notification attributes, PushIt also supports links, custom badges and initiating background downloads for certain Newsstand apps.

### devices

To show the list of available devices, use `$ pushit devices` to print a list of all the available devices, along with their tokens.

You can filter the list of devices shown by device model. `$ pushit devices --filter "iPad"` will output all the iPads form your device list. The filter is case-insensitive.

To populate the list of devices, add a `devices.yaml` file to the current directory. This file should include data about all the devices you'd like to be available to you, as it will define the `@devices` Hash. The structure for this is as follows:

```yaml
:device_name:
  :model: iPhone 5
  :token: <token goes here including the angle brackets>
```

Note that the keys start with `:` as the values are accessed using symbols, and that indentation must be 2 spaces, not a tab.

### push

The most basic of `push` commands only specifies the device you are sending to and a message, badge, sound or newsstand argument - assuming you have a valid certificate named `cert.pem` in the current directory.

	$ pushit push device_name -m "Hello from PushIt"

It is compulsory to use at least one of the `message`, `badge`, `sound` or `newsstand` options. If you fail to use one of these, you will be asked to enter a message for your notification before it is sent.

When using the `--app` option, the certificate for that app should be named the same as the app name you specify, in `.pem` format. If the certificate you'd like to use isn't in the current directory, you can include a relative filepath to it.

The following options take String parameters as shown below:
	
	--message "Hello from PushIt"
	--sound "sosumi.aiff"
	--link "itunes"
	--button "install"

The following options require numbers to be specified:

	--download 33589
	--badge 1

`--newsstand` will set the `content-available` attribute to `1` if specified.

You can change the environment to Production (rather than Development) using:

	$ pushit push device_name -b 1 --environment :production

Finally, you can send the `--debug` option with your command to enable debug logging. Debug logs will appear in blue, thanks to [colored](http://rubygems.org/gems/colored)

For any additional information, use the `help` option:

	$ pushit help

If all has gone well, you should get a nice green message in your terminal window to tell you that the notification has been sent successfully.