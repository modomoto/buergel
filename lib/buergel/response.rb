require 'crack/xml'

module Buergel
  class Response

    ADDRESS_UNCHANGED = 0
    ADDRESS_KNOWN = 1
    ADDRESS_UPDATED = 2
    ADDRESS_CORRECTED = 3
    ADDRESS_CORRECTED_AND_FOUND = 4

    attr_accessor :first_name, :last_name, :street, :street_no,
    :zip, :city, :phone, :birth_date, :email, :score,
    :ret_code, :address_origin, :address_origin_text,
    :note

    def initialize (response_body)
      data = Crack::XML.parse response_body
      interpret_ret_code data['BWIDATA']['HEADER']['RETCODE']
      response = data['BWIDATA']['C55QN53'] || data['BWIDATA']['C55QN54']
      self.assign response
    end

    def assign response
      self.first_name = response['VORNAME']
      self.last_name = response['NAME1']
      self.street = response['STRASSE']
      self.street_no = response['HAUS_NR']
      self.zip = response['PLZ']
      self.city = response['ORT']
      self.phone = response['TELEFON_NR']
      self.birth_date = response['GEBURTSDATUM']
      self.email = response['EMAIL_ADRESSE']
      self.address_origin = response['ANSCHR_HERKUNFT'].to_i
      self.score = response['SCORE_WERT'].to_i / 10.0
      @country_code = response['STAAT']
      self.address_origin_text = response['ANSCHR_HERKUNFT_TEXT']
      self.note = response['HINWEIS_TEXT']
    end

    # defines wether the addres is unchanged or corrected
    # allowed values are:
    # ADDRESS_UNCHANGED, ADDRESS_KNOWN, ADDRESS_UPDATED, ADDRESS_CORRECTED, ADDRESS_CORRECTED_AND_FOUND
    # for details please look at the official Buergel docs


    #returns object of type IsoCountryCodes::Code
    def country
      if(@country_code.to_i == 280)
        IsoCountryCodes.find(276) #since 1990 we use 176 for whole germany, 280 was for "west germany" WTF
      else
        IsoCountryCodes.find(@country_code)
      end
    end


    def interpret_ret_code ret_code
      if ret_code == '00000000'
        return true
      else
        a = ret_code[0..2]
        b = ret_code[3..6]
        c = ret_code[7]

        if a.to_i == 9
          raise Buergel::BuergelException, "Invalid Login for Buergel, error code: #{a} - #{b} - #{c}"
        elsif a.to_i == 7
          raise Buergel::BuergelException, "Technical problem with Buergel request, error code: #{a} - #{b} - #{c}"
        elsif a.to_i == 2 && (b.to_i == 1100 || b.to_i == 112 || b.to_i == 111 || b.to_i == 013 || b.to_i == 101)#wrong address
          raise Buergel::BuergelInvalidAddressException, "Invalid Address, error code: #{a} - #{b} - #{c}"
        else
          raise Buergel::BuergelException, "Invalid request data for Buergel, error code: #{a} - #{b} - #{c}"
        end
      end
    end

  end

end