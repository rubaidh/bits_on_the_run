# Core Ruby libraries
require 'digest/sha1'
require 'uri'
require 'rexml/document'
require 'open-uri'

# External gem dependencies.
require 'active_support'

require File.join File.dirname(__FILE__), 'bits_on_the_run', 'initializer'
require File.join File.dirname(__FILE__), 'bits_on_the_run', 'configuration'
require File.join File.dirname(__FILE__), 'bits_on_the_run', 'client'
require File.join File.dirname(__FILE__), 'bits_on_the_run', 'video'

module BitsOnTheRun
end
