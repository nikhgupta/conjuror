source 'https://rubygems.org'

# Specify your gem's dependencies in conjuror.gemspec
gemspec

group :test do
  # mime-types is required indirectly by coveralls
  # needs to be < 2.0 to work with Ruby 1.8.7
  gem 'mime-types', '~> 1.0', :platforms => [:ruby_18, :jruby]
  gem 'coveralls', :require => false
end
