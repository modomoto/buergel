require_relative '../../test_helper'

describe Buergel::ConCheckBasic do

  it "should define correct defaults" do
    Buergel.customer_no = '123'
    Buergel.user_id = '321'
    Buergel.password = 'pw'

    b = Buergel::ConCheckBasic.new()
    b.data['BWIDATA']['HEADER']['SYSTEM_CODE'].must_equal('BAS')
    b.data['BWIDATA']['C55QN01']['PRODUKT_NR'].must_equal(42)
    b.data['BWIDATA']['C55QN01']['ANF_GRUND'].must_equal('0003')
  end


end