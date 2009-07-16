require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include BitsOnTheRun

describe Initializer do
  describe "self.run" do
    after(:each) do
      # Reset global state
      Configuration.api_key = nil
      Configuration.api_secret = nil
    end

    it "should allow the user to configure an API key and secret" do
      Initializer.run do |config|
        config.api_key = "api key"
        config.api_secret = "api secret"
      end
      Configuration.api_key.should == "api key"
      Configuration.api_secret.should == "api secret"
    end

    it "should raise an error if there is no API key specified" do
      lambda {
        Initializer.run do |config|
          config.api_secret = "api secret"
        end
      }.should raise_error(ConfigurationError)
    end

    it "should raise an error if there is no API secret specified" do
      lambda {
        Initializer.run do |config|
          config.api_key = "api key"
        end
      }.should raise_error(ConfigurationError)
    end
  end
end
