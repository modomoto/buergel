# coding: utf-8
require_relative '../../test_helper'
 
describe Buergel do
# TESTS disabled, as you need credentials to run them
#  before (:each) do
#    Buergel.customer_no = ''
#    Buergel.user_id = ''
#    Buergel.password = ''
#    Buergel.test_mode = true
#    @buergel = Buergel::ConCheckBasic.new()
#  end 
# 
#  it "should raise exception with wrong credentials" do
#    Buergel.customer_no = 'something'
#    Buergel.user_id = 'Im'
#    Buergel.password = 'wrong'
#    buergel = Buergel::ConCheckBasic.new()
#    VCR.use_cassette('wrong_credentials') do
#      assert_raises(Buergel::BuergelException){buergel.request("name1", "name2", "street", "123", "321", "city", "de")}
#    end
#  end   
#
#  it "should work with various test data" do
#    VCR.use_cassette('test data 1') do
#      response = @buergel.request("Johann", "Müller", "Neue Querstr.", "15", "23552", "Lübeck", "de")
#      response.score.must_equal(6.0)
#      response.last_name.must_equal("Müller")
#      response.country.alpha2.must_equal("DE")
#      response.address_origin.must_equal(1)
#    end
#   VCR.use_cassette('test data 2') do
#      response =  @buergel.request("François", "Böhm", "Nienhüsener Str.", "36", "23560", "Lübeck", "de")
#      response.score.must_equal(2.7)
#      response.first_name.must_equal("François")
#      response.country.alpha2.must_equal("DE")
#      response.address_origin.must_equal(1)
#   end
#    VCR.use_cassette('test data 3') do
#      response = @buergel.request("Enrico", "Voigt", "Mummendorfer Str.", "76", "23936", "Mallentin", "de")
#      response.score.must_equal(3.1)
#      response.last_name.must_equal("Voigt")
#      response.country.alpha2.must_equal("DE")
#      response.address_origin.must_equal(1)
#    end
#    VCR.use_cassette('test data 4') do
#      response = @buergel.request("Rafael", "Kasleer", "Kreutzkamp", "53", "23795", "Bad Segeberg", "de")
#      response.score.must_equal(5.4)
#      response.last_name.must_equal("Kaesler")
#      response.country.alpha2.must_equal("DE")
#      response.address_origin.must_equal(4)
#    end
#  end

end