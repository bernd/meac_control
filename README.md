## MEACControl

The library provides some Ruby classes to interact with a Mitsubishi Electric
G-50A centralized controller. This device is used to control up to 50 indoor
air conditioning units.

The G-50A offers a XML API for the communication.

So far, the library has only been tested with a G-50A. I'm not sure if there
are other controller/devices which use the same API.

### Security

Mitsubishi recommends to put the controller into a private network. In fact,
there's no authentication or encryption needed to access the controller.
There's been a post to the BugTraq mailing list in March 2008 regarding that.
[Archive](http://www.securityfocus.com/archive/1/489970)

### Code Examples

Please see the `example` directory for code examples.

### Note on Patches/Pull Requests

* Fork the project.
* Write a spec to cover a bug or a new feature.
* Make your feature addition or bug fix.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a
  commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

### Copyright

Copyright (c) 2010 Bernd Ahlers. See LICENSE for details.
