# Core Ruby libraries
require 'digest/sha1'
require 'uri'
require 'rexml/document'

# External gem dependencies.
gem 'activesupport'; require 'active_support'
gem 'curb'; require 'curb'

require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'initializer')
require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'configuration')
require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'client')
require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'video')
require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'video_create_response')
require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'video_template')
require File.join(File.dirname(__FILE__), 'bits_on_the_run', 'video_conversion')

module BitsOnTheRun
end
