require 'minitest/autorun'
require 'minitest/pride'

require 'vcr'

require File.expand_path('../../lib/buergel.rb', __FILE__)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end