require 'yaml'
require 'fileutils'
require 'singleton'
require 'rubygems'
require "conjuror/version"
require "conjuror/settings"

module Conjuror

  class NoConfigurationLoadedError < StandardError
    def initialize message = "You must call 'use' to load the appropriate configuration."
      super
    end
  end

  def self.new name = nil, file = nil
    Settings.instance.use name, file
  end
end
