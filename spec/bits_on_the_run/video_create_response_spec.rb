require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include BitsOnTheRun

describe VideoCreateResponse do
  before(:each) do
    Initializer.run do |config|
      config.api_key    = 'api key'
      config.api_secret = 'api secret'
    end
  end

  after(:each) do
    Configuration.api_key    = nil
    Configuration.api_secret = nil
  end

  describe "Getting a video from the API (/video/show)" do
    before(:each) do
      xml = <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <response>
        <status>ok</status>
        <video key="vtQmcboj">
          <link>
            <protocol>http</protocol>
            <address>upload.bitsontherun.com</address>
            <path>/v1/videos/upload</path>
            <query total="2">
              <key>vtQmcboj</key>
              <token>e2bbad0fd889d5d2e30047596cfe3789778257d2</token>
            </query>
          </link>
        </video>
      </response>
      XML

      @response = VideoCreateResponse.new(REXML::Document.new(xml))
    end

    it "should have a video key of 'vtQmcboj'" do
      @response.key.should == 'vtQmcboj'
    end

    it "should have a URL of 'http://upload.bitsontherun.com/v1/videos/upload?api_format=xml&key=vtQmcboj&token=e2bbad0fd889d5d2e30047596cfe3789778257d2'" do
      @response.send(:url).should == 'http://upload.bitsontherun.com/v1/videos/upload?api_format=xml&key=vtQmcboj&token=e2bbad0fd889d5d2e30047596cfe3789778257d2'
    end
  end
end