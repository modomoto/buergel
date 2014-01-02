require_relative '../../test_helper'

describe Buergel::Response do
  describe 'ConCheckBasic response' do
    before(:all) do
      example = '<?xml version="1.0" encoding="iso-8859-1"?>
<BWIDATA>
  <HEADER>
    <HEADER_ID>A001</HEADER_ID>
    <HEADER_VERSION>01</HEADER_VERSION>
    <SYSTEM_CODE>BAS</SYSTEM_CODE>
    <KOMM_METHODE>TS</KOMM_METHODE>
    <KOMM_TIMEOUT_SEKUNDEN>003</KOMM_TIMEOUT_SEKUNDEN>
    <KOMM_PARAMETER/>
    <GP_ID>C55QN01</GP_ID>
    <GP_VERSION>0003</GP_VERSION>
    <KNDNR>99999999</KNDNR>
    <KNDFILIALE/>
    <TRANSCODE/>
    <TRANSTMS/>
    <RETCODE>00000000</RETCODE>
    <RETTMS>2008-03-25-14.49.14.074993</RETTMS>
    <TRANSFNK>AN</TRANSFNK>
    <TRANSSEQ/>
    <USERID>09919999</USERID>
    <SEGMENTNAME>C55QN53</SEGMENTNAME>
    <SEGMENTVERSION>0203</SEGMENTVERSION>
    <FREMD_USERID/>
    <DIALOGSPRACHE>01</DIALOGSPRACHE>
    <PROG_VERSION>01</PROG_VERSION>
    <XML_MARKUP_KZ>01</XML_MARKUP_KZ>
  </HEADER>
  <C55QN53>
    <ASNR>99</ASNR>
    <ANF_NR>200010115</ANF_NR>
    <KND_KEY1/>
    <KND_KEY2/>
    <VORNAME>Gustav</VORNAME>
    <NAME1>Fauler</NAME1>
    <NAME2/>
    <STRASSE>Waldweg</STRASSE>
    <HAUS_NR>1f</HAUS_NR>
    <PLZ>18119</PLZ>
    <ORT>Rostock</ORT>
    <STAAT>280</STAAT>
    <STAAT_TXT>Bundesrepublik Deutschland</STAAT_TXT>
    <GEBURTSDATUM>05.05.1955</GEBURTSDATUM>
    <TELEFON_NR/>
    <EMAIL_ADRESSE/>
    <ANSCHR_HERKUNFT>1</ANSCHR_HERKUNFT>
    <ANSCHR_HERKUNFT_TEXT>Angefragte Person/Adresse in Datenbank gefunden</ANSCHR_HERKUNFT_TEXT>
    <SCORE_WERT>0060</SCORE_WERT>
    <HINWEIS_TEXT>Person und Anschrift bekannt; Uns liegen Negativmerkmale vor</HINWEIS_TEXT>
  </C55QN53>
</BWIDATA>'
      @r = Buergel::Response.new(example)
    end

    it "should parse xml" do
      @r.first_name.must_equal("Gustav")
      @r.last_name.must_equal('Fauler')
      @r.street_no.must_equal('1f')
      @r.country.alpha2.must_equal('DE')
      @r.birth_date.must_equal('05.05.1955')
      @r.email.must_equal(nil)
      @r.score.must_equal(6.0)
      @r.address_origin.must_equal(Buergel::Response::ADDRESS_KNOWN)
    end

    it "interprets success ret code correctly" do
      @r.interpret_ret_code('00000000').must_equal(true)
    end

    it "interprets error ret code as error" do
      assert_raises(Buergel::BuergelException) {@r.interpret_ret_code '00200000'}
      assert_raises(Buergel::BuergelException) {@r.interpret_ret_code '00400000'}
      assert_raises(Buergel::BuergelException) {@r.interpret_ret_code '00700000'}
      assert_raises(Buergel::BuergelException) {@r.interpret_ret_code '00900000'}
      assert_raises(Buergel::BuergelInvalidAddressException) {@r.interpret_ret_code '00211000'}
    end
  end

  describe 'ConCheckMove response' do
    before(:all) do
      con_check_move_response = "<?xml version=\"1.0\" encoding=\"iso-8859-1\" standalone=\"no\"?>
<BWIDATA>
  <HEADER>
    <HEADER_ID>A001</HEADER_ID>
    <HEADER_VERSION>01</HEADER_VERSION>
    <SYSTEM_CODE>BAS</SYSTEM_CODE>
    <KOMM_METHODE>TS</KOMM_METHODE>
    <KOMM_TIMEOUT_SEKUNDEN>003</KOMM_TIMEOUT_SEKUNDEN>
    <KOMM_PARAMETER/>
    <GP_ID>C55QN01</GP_ID>
    <GP_VERSION>0004</GP_VERSION>
    <KNDNR>54745895</KNDNR>
    <KNDFILIALE/>
    <TRANSCODE/>
    <TRANSTMS/>
    <RETCODE>00000000</RETCODE>
    <RETTMS>2014-01-02-15.48.26.082704</RETTMS>
    <TRANSFNK>AN</TRANSFNK>
    <TRANSSEQ/>
    <USERID>09914842</USERID>
    <SEGMENTNAME>C55QN54</SEGMENTNAME>
    <SEGMENTVERSION>0204</SEGMENTVERSION>
    <FREMD_USERID/>
    <DIALOGSPRACHE>01</DIALOGSPRACHE>
    <PROG_VERSION>01</PROG_VERSION>
    <XML_MARKUP_KZ>02</XML_MARKUP_KZ>
  </HEADER>
  <C55QN54>
    <ASNR>99</ASNR>
    <ANF_NR>289441498</ANF_NR>
    <KND_KEY1/>
    <KND_KEY2/>
    <VORNAME><![CDATA[Gustav]]></VORNAME>
    <NAME1><![CDATA[Fauler]]></NAME1>
    <NAME2/>
    <STRASSE><![CDATA[Waldweg]]></STRASSE>
    <HAUS_NR>1f</HAUS_NR>
    <PLZ>18119</PLZ>
    <ORT><![CDATA[Rostock]]></ORT>
    <STAAT>276</STAAT>
    <STAAT_TXT><![CDATA[Deutschland]]></STAAT_TXT>
    <GEBURTSDATUM>05.05.1955</GEBURTSDATUM>
    <TELEFON_NR/>
    <EMAIL_ADRESSE/>
    <ANSCHR_HERKUNFT>0</ANSCHR_HERKUNFT>
    <ANSCHR_HERKUNFT_TEXT><![CDATA[Ausgabedaten entsprechen Eingabe]]></ANSCHR_HERKUNFT_TEXT>
    <SCORE_WERT>0028</SCORE_WERT>
    <HINWEIS_TEXT><![CDATA[Person unbekannt/Anschrift bekannt; Statistisches Ausfallrisiko: Mittel]]></HINWEIS_TEXT>
    <NM_ANZ>0</NM_ANZ>
    <NM_TAB/>
    <VH_ANZ>0</VH_ANZ>
    <VH_TAB/>
  </C55QN54>
</BWIDATA>"
      @buergel_response = Buergel::Response.new(con_check_move_response)
    end

    it 'parses the response' do
      @buergel_response.first_name.must_equal("Gustav")
      @buergel_response.last_name.must_equal('Fauler')
      @buergel_response.street_no.must_equal('1f')
      @buergel_response.country.alpha2.must_equal('DE')
      @buergel_response.birth_date.must_equal('05.05.1955')
      @buergel_response.email.must_equal(nil)
      @buergel_response.score.must_equal(2.8)
      @buergel_response.note.must_equal('Person unbekannt/Anschrift bekannt; Statistisches Ausfallrisiko: Mittel')
    end

  end
end