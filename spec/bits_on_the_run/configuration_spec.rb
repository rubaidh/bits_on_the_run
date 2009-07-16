require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BitsOnTheRun::Configuration do
  it "should have a default API version of v1" do
    BitsOnTheRun::Configuration.api_version.should == "v1"
  end

  it "should have a default API URL of http://api.bitsontherun.com/" do
    BitsOnTheRun::Configuration.api_url.should == "http://api.bitsontherun.com/"
  end

  it "should not set a default api key" do
    BitsOnTheRun::Configuration.api_key.should be_nil
  end

  it "should not set a default api secret" do
    BitsOnTheRun::Configuration.api_secret.should be_nil
  end
end
