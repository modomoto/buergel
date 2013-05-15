require 'iso_country_codes'
require 'gyoku'
require "net/https"
require "uri"

module Buergel
  class Base
    attr_accessor :data

    LANG_MAPPING = {
      'de' => 1,
      'en' => 2,
      'fr' => 3,
      'es' => 4,
      'it' => 5
    }

    PRODUCTION_URL = 'https://www.buergel-online.de/rcs/xml.jsp'
    TEST_URL = 'https://www.buergel-online.de/rcstest/xml.jsp'

    def initialize(data={})
      raise(Buergel::BuergelException, "Customer id is mandatory") if Buergel.customer_no.nil?
      raise(Buergel::BuergelException, "User id is mandatory") if Buergel.user_id .nil?
      raise(Buergel::BuergelException, "Password is mandatory") if Buergel.password.nil?

      @data = self.defaults.merge(data)
    end

    def defaults
      {
        'BWIDATA' => {
          'HEADER' => {
            'SYSTEM_CODE' => 'BAS',
            'KOMM_METHODE' => 'TS',
            'KOMM_TIMEOUT_SEKUNDEN' => '003',
            'GP_ID' => 'C55QN01',
            'KNDNR' => Buergel.customer_no,
            'KNDFILIALE' => "",
            'TRANSFNK' => 'AN',
            'USERID' => Buergel.user_id,
            'SEGMENTNAME' => 'C55QN01',
            'FREMD_USERID' => "",
            'DIALOGSPRACHE' => '01',
            'XML_MARKUP_KZ' => '02'
            },
          'C55QN01' => {
            'VERSANDART' => 6,
            'ANF_ART' => 70,
            'LIEFERSPRACHE' => 1,
            'KND_KEY1' => "",
            'KND_KEY2' => ""
          }
        }
      }
    end

    def check_data
      #make sure all required files by subclasses are set
    end

    def set_lang iso
      lang_code = Buergel::Base::LANG_MAPPING[iso]
      unless lang_code && lang_code > 0
        raise Buergel::BuergelException, "unknown language iso"
      end
      @data['BWIDATA']['C55QN01']['LIEFERSPRACHE'] = lang_code
    end 

    # queries the buergel api for a the given address
    # country_code can be anything, iso2, iso3 or numeric, see http://github.com/alexrabarts/iso_country_codes
    def request first_name, last_name, street, street_no, zip, city, country_code
      xml = construct_xml first_name, last_name, street, street_no, zip, city, country_code
      xml = CGI::escape xml# URI.escape xml
      uri = URI.parse("#{get_url}?eing_dat=#{xml}")
      #uri.query = URI.encode_www_form('eing_dat' => xml)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(Buergel.user_id , Buergel.password)
      request.content_type = 'iso-8859-1'
      response = http.request(request)
      
      if response.code == "401"
        raise Buergel::BuergelException, "Wrong credentials"
      elsif response.code != "200"
        raise Buergel::BuergelException, "unknown error"
      end
      Buergel::Response.new(response.body)
    end

    def construct_xml first_name, last_name, street, street_no, zip, city, country_code
      country_iso = IsoCountryCodes.find(country_code).numeric
      request = {
        'VORNAME' => first_name,
        'NAME1' => last_name,
        'STRASSE' => street,
        'HAUS_NR' => street_no,
        'PLZ' => zip,
        'ORT' => city,
        'STAAT' => country_iso
      }
      @data['BWIDATA']['C55QN01'] = @data['BWIDATA']['C55QN01'].merge(request)
      '<?xml version="1.0" encoding="iso-8859-1"?>' + Gyoku.xml(@data)
    end

    def get_url
      Buergel.test_mode ? Buergel::Base::TEST_URL : Buergel::Base::PRODUCTION_URL
    end
  end
end