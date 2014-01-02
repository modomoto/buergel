module Buergel
  class ConCheckMove < Buergel::Base

    def defaults
      d = super
      d['BWIDATA']['C55QN01']['PRODUKT_NR'] = 47
      d['BWIDATA']['HEADER']['SEGMENTVERSION'] = '0204'
      d['BWIDATA']['C55QN01']['ANF_GRUND'] = '0003'
      d
    end

  end
end