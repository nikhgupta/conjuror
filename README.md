# Conjuror

Easily conjure configuration settings for your standalone ruby applications.
`Conjuror` creates configuration file for projects at a centralized place in the
user's home directory, and allow each project to have a unique and separate
configuration directory of itself.

[![Build Status](https://travis-ci.org/nikhgupta/conjuror.png?branch=develop)](https://travis-ci.org/nikhgupta/conjuror)
[![Coverage Status](https://coveralls.io/repos/nikhgupta/conjuror/badge.png)](https://coveralls.io/r/nikhgupta/conjuror)
[![Code Climate](https://codeclimate.com/github/nikhgupta/conjuror.png)](https://codeclimate.com/github/nikhgupta/conjuror)
[![Gem Version](https://badge.fury.io/rb/conjuror.png)](http://badge.fury.io/rb/conjuror)
[![Dependency Status](https://gemnasium.com/nikhgupta/conjuror.png)](https://gemnasium.com/nikhgupta/conjuror)

## Installation

Add this line to your application's Gemfile:

    gem 'conjuror'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install conjuror

## Usage

Let's say, that you are developing a gem with the name `awesome`, and you want
a configuration file for that project, well, you can do something like:

	settings = Conjuror.new "awesome", "filename"
	settings["opt"] = "value" # setting an option saves the file automatically
	settings.path #=> ~/.conjuror/awesome/filename.yml
	
The above will create the `~/.conjuror/awesome` directory for you, along with
your configuration file (named `filename.yml`) for you. Second argument is
optional, and will create a file named `conf.yml` if you do not specify it.

Now, `Conjuror` uses the first file specified in the `initializer` as the
default, and starts with it. To create a new setting, you can do:

	settings["option"] = "value"       # saved instantly to the YAML config file
	settings["option"] #=> value       # easily access your settings
	settings.option	   #=> value       # allows access using 'dot' syntax

Note that, settings are persisted to the local configuration file on disk nearly
instantly.

You are, also, able to switch to different projects or configuration files,
easily like this:

	settings.use "anotherproject"       # switch to 'anotherproject#conf'
	settings.use "awesome", "filename"  # switch to 'awesome#filename'
	settings.file = 'configuration'     # switch to 'awesome#configuration'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
