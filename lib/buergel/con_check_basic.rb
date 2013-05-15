module Buergel
  class ConCheckBasic < Buergel::Base

    def defaults
      d = super
      d['BWIDATA']['C55QN01']['PRODUKT_NR'] = 42
      d['BWIDATA']['C55QN01']['SEGMENTVERSION'] = '0203'
      d['BWIDATA']['C55QN01']['ANF_GRUND'] = '0003'
      d
    end

  end
end