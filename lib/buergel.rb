require_relative "buergel/version"

module Buergel
  class << self
    attr_accessor :customer_no, :user_id, :password, :test_mode
  end
  Buergel.customer_no = ENV['BUERGEL_CUSTOMER_NO']
  Buergel.customer_no = ENV['BUERGEL_USER_ID']
  Buergel.customer_no  = ENV['BUERGEL_PASSWORD']
  Buergel.test_mode = ENV['BUERGEL_TEST_MODE']
end

require_relative 'buergel/base.rb'
require_relative 'buergel/con_check_basic.rb'
require_relative 'buergel/response.rb'
require_relative 'buergel/buergel_exception.rb'