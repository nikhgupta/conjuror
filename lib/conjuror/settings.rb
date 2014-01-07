module Conjuror
  class Settings

    include Singleton

    attr_reader :name, :file, :data

    # Returns an instance of the class itself.
    #
    def use name = nil, file = nil
      self.name = name
      self.file = file
      self
    end

    def file= file
      @file = (file ? file.to_s : "conf")
      @data = (YAML.load_file(self.path) rescue {})
    end

    def path
      raise Conjuror::NoConfigurationLoadedError unless @name && @file
      File.join(self.directory, @file + ".yml")
    end

    # def reload
    #   self.use @name, @file
    # end

    def [] key
      @data[key]
    end

    # ensures that every new setting is first persisted to the file.
    def []= key, value
      @data[key] = value
      save_configuration
      value
    end

    def directory
      self.class.directory_for(@name)
    end

    def method_missing *args
      return @data[args.first.to_s] if @data && config_defined?(args.first.to_s)
      return @data[args.first.to_sym] if @data && config_defined?(args.first.to_sym)
      raise NoMethodError, "Found no such method."
    end

    def self.directory_for(name)
      File.join(ENV['HOME'], ".conjuror", name.to_s.gsub(/^\.+/, ''))
    end

    private

    def name= name
      @name = name
      FileUtils.mkdir_p self.directory unless File.directory? self.directory
    end

    def save_configuration
      File.open(self.path, "w") { |f| f.puts @data.to_yaml }
      @data
    end

    def config_defined? key
      @data.has_key? key
    end

  end
end
