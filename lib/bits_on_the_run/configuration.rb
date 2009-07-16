module BitsOnTheRun
  class ConfigurationError < StandardError
  end

  class Configuration
    cattr_accessor :api_key
    cattr_accessor :api_secret

    cattr_accessor :api_url
    self.api_url = "http://api.bitsontherun.com/"

    cattr_accessor :api_version
    self.api_version = "v1"
  end
end
