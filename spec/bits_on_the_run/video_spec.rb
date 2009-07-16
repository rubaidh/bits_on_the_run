require File.dirname(__FILE__) + '/../spec_helper'

include BitsOnTheRun

describe Video do
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
      client = Client.new('/some/action')
      client.stub!(:response).and_return REXML::Document.new <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <response>
        <status>ok</status>
        <video key="yYul4DRz">
          <author>Bits on the Run</author>
          <date>1225962900</date>
          <description>New video</description>
          <duration>12.0</duration>
          <link>http://www.bitsontherun.com</link>
          <status>ready</status>
          <tags>new, video</tags>
          <title>New test video</title>
        </video>
      </response>
      XML
      Client.stub!(:new).and_return(client)

      @video = Video.show("yYul4DRz")
    end

    it "should return a video instance" do
      @video.should be_a(Video)
    end

    it "should have the video key supplied by the API" do
      @video.key.should == "yYul4DRz"
    end

    it "should have the author 'Bits on the Run'" do
      @video.author.should == "Bits on the Run"
    end

    it "should have the date 'Thu Nov 06 09:15:00 +0000 2008'" do
      @video.date.should == Time.at(1225962900)
    end

    it "should have the description 'New video'" do
      @video.description.should == "New video"
    end

    it "should have the duration 12 seconds" do
      @video.duration.to_i.should == 12.seconds
    end

    it "should have the link 'http://www.bitsontherun.com'" do
      @video.link.should == 'http://www.bitsontherun.com'
    end

    it "should have the tags 'new' and 'video'" do
      @video.tags.should == ["new", "video"]
    end

    it "should have the title 'New test video'" do
      @video.title.should == 'New test video'
    end
  end
end
