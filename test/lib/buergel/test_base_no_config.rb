require_relative '../../test_helper'

describe Buergel::Base do

  it "userid is mandatory" do
    Buergel.customer_no = "test"
    Buergel.user_id = nil
    Buergel.password = "123"
    assert_raises(Buergel::BuergelException) { Buergel::Base.new()}
  end

  it "pw is mandatory" do
    Buergel.customer_no = "123"
    Buergel.user_id = "321"
    Buergel.password = nil
    assert_raises(Buergel::BuergelException) { Buergel::Base.new()}
  end

  it "customer_no is mandatory" do
    Buergel.customer_no = nil
    Buergel.user_id = "321"
    Buergel.password = "123"
    assert_raises(Buergel::BuergelException) { Buergel::Base.new()}
  end

end