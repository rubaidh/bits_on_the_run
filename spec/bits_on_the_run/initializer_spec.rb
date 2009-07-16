require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BitsOnTheRun::Initializer do
  describe "self.run" do
    after(:each) do
      # Reset global state
      BitsOnTheRun::Configuration.api_key = nil
      BitsOnTheRun::Configuration.api_secret = nil
    end

    it "should allow the user to configure an API key and secret" do
      BitsOnTheRun::Initializer.run do |config|
        config.api_key = "api key"
        config.api_secret = "api secret"
      end
      BitsOnTheRun::Configuration.api_key.should == "api key"
      BitsOnTheRun::Configuration.api_secret.should == "api secret"
    end

    it "should raise an error if there is no API key specified" do
      lambda {
        BitsOnTheRun::Initializer.run do |config|
          config.api_secret = "api secret"
        end
      }.should raise_error(BitsOnTheRun::ConfigurationError)
    end

    it "should raise an error if there is no API secret specified" do
      lambda {
        BitsOnTheRun::Initializer.run do |config|
          config.api_key = "api key"
        end
      }.should raise_error(BitsOnTheRun::ConfigurationError)
    end
  end
end
