require 'spec_helper'

describe Conjuror do

  before(:each) do
    [ "conjuror", "randomname" ].each do |name|
      FileUtils.rm_rf Conjuror::Settings.directory_for(name)
    end
  end

  it 'has a version number' do
    expect(Conjuror::VERSION).not_to be_nil
  end

  describe "#new" do
    subject { Conjuror.new }

    it 'creates an instance of Settings class' do
      result = subject.is_a?(Conjuror::Settings)
      expect(result).to be_true
    end

    it 'does not create another instance of itself' do
      result = subject === Conjuror.new
      expect(result).to be_true
    end
  end
end

describe Conjuror::Settings do

  before(:each) do
    [ "conjuror", "randomname" ].each do |name|
      FileUtils.rm_rf Conjuror::Settings.directory_for(name)
    end
    Singleton.__init__(Conjuror::Settings)
  end

  subject(:settings) { Conjuror::Settings.instance }

  describe "#new" do
    it 'raises an error when an attempt to create an instance is made' do
      expect { Conjuror::Settings.new }.to raise_error(NoMethodError)
    end
  end

  describe "#path" do
    it 'raises an error when configuration was accessed but not loaded' do
      expect { settings.path }.to raise_error
    end
  end

  describe "#use" do
    it 'creates a configuration directory when properly loaded' do
      directory = settings.use("conjuror").directory

      expect(File.basename(directory)).to eq("conjuror")
      expect(directory).to eq(File.expand_path("~/.conjuror/conjuror"))
      expect(File.directory?(directory)).to be_true
    end

    it 'chooses a default configuration file if none specified' do
      settings.use("conjuror")
      settings["option"] = "value" # triggers the saving of config file

      expect(settings.file).to eq("conf")
      expect(File.file?(settings.path)).to be_true
    end

    it "returns an instance of itself" do
      result = settings.use("conjuror") === settings
      expect(result).to be_true
    end
  end

  describe "#[], #[]=" do
    it "allows easy access and creation of new settings" do
      settings.use("conjuror")
      expect(settings["option"]).to be_nil

      settings["option"] = "value"
      expect(settings["option"]).to eq("value")
      expect(settings.option).to eq("value")
    end

    it 'saves the new settings to the disk' do
      settings.use("conjuror")
      settings["option"] = "value"

      result = YAML.load_file(settings.path)["option"]
      expect(result).to eq("value")
    end
  end

  describe "#file=" do
    it "allows switching to a different configuration files and projects" do
      settings.use "conjuror"                   # use: conjuror, conf
      settings["option"] = "value1"
      settings.file = "otherfile"               # use: conjuror, otherfile
      settings["option"] = "value2"

      settings.use "randomname"                 # use: randomname, conf
      settings["option"] = "value3"
      settings.file = "otherfile"               # use: randomname, otherfile
      settings["option"] = "value4"

      settings.file = "conf"                    # use: randomname, "conf"
      expect(settings.option).to eq("value3")

      settings.use "conjuror", "otherfile"      # use: conjuror, otherfile
      expect(settings.option).to eq("value2")

      settings.file = nil                       # use: conjuror, "conf"
      expect(settings.option).to eq("value1")

      settings.use "randomname", "otherfile"      # use: randomname, otherfile
      expect(settings.option).to eq("value4")
    end
  end

end
