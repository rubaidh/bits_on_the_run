require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include BitsOnTheRun

describe Configuration do
  it "should have a default API version of v1" do
    Configuration.api_version.should == "v1"
  end

  it "should have a default API URL of http://api.bitsontherun.com/" do
    Configuration.api_url.should == "http://api.bitsontherun.com/"
  end

  it "should not set a default api key" do
    Configuration.api_key.should be_nil
  end

  it "should not set a default api secret" do
    Configuration.api_secret.should be_nil
  end
end
