# Conjuror

Easily conjure configuration settings for your standalone ruby applications.
`Conjuror` creates configuration file for projects at a centralized place in the
user's home directory, and allow each project to have a unique and separate
configuration directory of itself.

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
