require_relative "buergel/version"

module Buergel
  class << self
    attr_accessor :customer_no, :user_id, :password, :test_mode

    def search_type
      @search_type
    end

    def search_type=(st)
      raise(Buergel::BuergelException, "Search type must be nil, 00 or 01") unless st.nil? or st.to_s.match(/00|01/)
      @search_type = st
    end
  end
  Buergel.customer_no = ENV['BUERGEL_CUSTOMER_NO']
  Buergel.customer_no = ENV['BUERGEL_USER_ID']
  Buergel.customer_no  = ENV['BUERGEL_PASSWORD']
  Buergel.test_mode = ENV['BUERGEL_TEST_MODE']
  Buergel.search_type = ENV['BUERGEL_SEARCH_MODE']
end

require_relative 'buergel/base.rb'
require_relative 'buergel/con_check_basic.rb'
require_relative 'buergel/con_check_move.rb'
require_relative 'buergel/response.rb'
require_relative 'buergel/buergel_exception.rb'
require_relative 'buergel/buergel_invalid_address_exception.rb'
