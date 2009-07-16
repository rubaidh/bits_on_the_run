module BitsOnTheRun
  class Initializer
    def self.run
      yield Configuration.new

      raise ConfigurationError.new("Must specify an API key for Bits on the run") if Configuration.api_key.blank?
      raise ConfigurationError.new("Must specify an API secret for Bits on the run") if Configuration.api_secret.blank?
    end
  end
end
