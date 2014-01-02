require_relative '../../test_helper'

describe Buergel::ConCheckMove do

  it "defines defaults" do
    Buergel.customer_no = '123'
    Buergel.user_id = '456'
    Buergel.password = 'password'

    con_check_move = Buergel::ConCheckMove.new()
    con_check_move.data['BWIDATA']['C55QN01']['PRODUKT_NR'].must_equal(47)
    con_check_move.data['BWIDATA']['HEADER']['SEGMENTVERSION'].must_equal('0204')
    con_check_move.data['BWIDATA']['C55QN01']['ANF_GRUND'].must_equal('0003')
  end

end