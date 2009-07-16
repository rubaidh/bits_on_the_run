require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include BitsOnTheRun

describe Client do
  describe "Client.parameterize" do
    it "should turn any old hash into a set of URL parameters" do
      Client.parameterize(:pot => "black", :kettle => "black").should == "kettle=black&pot=black"
    end
  end
  
  describe "with a valid configuration" do
    before(:each) do
      Initializer.run do |config|
        config.api_key    = 'api_key'
        config.api_secret = 'api_secret'
      end
    end

    after(:each) do
      Configuration.api_key    = nil
      Configuration.api_secret = nil
    end

    describe "with a constant time & nonce" do
      before(:each) do
        Time.stub!(:now).and_return(12345)
        Client.class_eval do
          alias_method :old_nonce, :nonce
          def nonce
            3
          end
        end
      end

      after(:each) do
        Client.class_eval do
          alias_method :nonce, :old_nonce
        end
      end

      describe "signature generation" do
        it "should generate a known good signature for a set of parameters" do
          c = Client.new('/videos/create', :foo => "bar")
          #  We know this signature is good because we calculated it by hand! :)
          c.send(:signature).should == "9158820216e67562f36dcc67678cf878b85488a0"
        end

        it "should not generate the same signature, given different parameters passed into the client" do
          c = Client.new('/videos/create', :foo => "baz")
          c.send(:signature).should_not == "9158820216e67562f36dcc67678cf878b85488a0"
        end
      end

      describe "url generation" do
        it "should generate a known good url with all the parameters, plus the signature" do
          c = Client.new('/videos/create', :video_key => "abcdefg")
          c.send(:url).should == "http://api.bitsontherun.com/v1/videos/create?api_format=xml&api_key=api_key&api_nonce=3&api_signature=5ca02cf70d371365c6e3dd945b6669db01883fee&api_timestamp=12345&video_key=abcdefg"
        end
      end
    end
  end

end
