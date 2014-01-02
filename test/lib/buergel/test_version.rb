require_relative '../../test_helper'

describe Buergel::VERSION do

  it "must be defined" do
    Buergel::VERSION.wont_be_nil
  end

end