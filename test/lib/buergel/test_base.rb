require_relative '../../test_helper'

describe Buergel::Base do

  before (:each) do
    Buergel.customer_no = '123'
    Buergel.user_id = '321'
    Buergel.password = 'pw'
    @buergel = Buergel::Base.new()
  end

  it "sets lang code" do
    @buergel.set_lang 'en'
    @buergel.data['BWIDATA']['C55QN01']['LIEFERSPRACHE'].must_equal(2)
  end

  it "raises on unknown lang code" do
    assert_raises(Buergel::BuergelException) {@buergel.set_lang('lt')}
  end

  it "constructs valid request xml" do
    answer = '<?xml version="1.0" encoding="iso-8859-1"?><BWIDATA><HEADER><SYSTEM_CODE>BAS</SYSTEM_CODE><KOMM_METHODE>TS</KOMM_METHODE><KOMM_TIMEOUT_SEKUNDEN>003</KOMM_TIMEOUT_SEKUNDEN><GP_ID>C55QN01</GP_ID><KNDNR>123</KNDNR><KNDFILIALE></KNDFILIALE><TRANSFNK>AN</TRANSFNK><USERID>321</USERID><SEGMENTNAME>C55QN01</SEGMENTNAME><FREMD_USERID></FREMD_USERID><DIALOGSPRACHE>01</DIALOGSPRACHE><XML_MARKUP_KZ>02</XML_MARKUP_KZ><SUCH_ART xsi:nil="true"/></HEADER><C55QN01><VERSANDART>6</VERSANDART><ANF_ART>70</ANF_ART><LIEFERSPRACHE>1</LIEFERSPRACHE><KND_KEY1></KND_KEY1><KND_KEY2></KND_KEY2><VORNAME>Hans</VORNAME><NAME1>Dampf</NAME1><STRASSE>Teststr.</STRASSE><HAUS_NR>12A</HAUS_NR><PLZ>12345</PLZ><ORT>Musterstadt</ORT><STAAT>276</STAAT><GEBURTSDATUM></GEBURTSDATUM></C55QN01></BWIDATA>'
    @buergel.construct_xml("Hans", "Dampf", "Teststr.", "12A", "12345", "Musterstadt", "de").must_equal(answer)
  end

  it "constructs valid request xml with birthdate" do
    answer = '<?xml version="1.0" encoding="iso-8859-1"?><BWIDATA><HEADER><SYSTEM_CODE>BAS</SYSTEM_CODE><KOMM_METHODE>TS</KOMM_METHODE><KOMM_TIMEOUT_SEKUNDEN>003</KOMM_TIMEOUT_SEKUNDEN><GP_ID>C55QN01</GP_ID><KNDNR>123</KNDNR><KNDFILIALE></KNDFILIALE><TRANSFNK>AN</TRANSFNK><USERID>321</USERID><SEGMENTNAME>C55QN01</SEGMENTNAME><FREMD_USERID></FREMD_USERID><DIALOGSPRACHE>01</DIALOGSPRACHE><XML_MARKUP_KZ>02</XML_MARKUP_KZ><SUCH_ART xsi:nil="true"/></HEADER><C55QN01><VERSANDART>6</VERSANDART><ANF_ART>70</ANF_ART><LIEFERSPRACHE>1</LIEFERSPRACHE><KND_KEY1></KND_KEY1><KND_KEY2></KND_KEY2><VORNAME>Hans</VORNAME><NAME1>Dampf</NAME1><STRASSE>Teststr.</STRASSE><HAUS_NR>12A</HAUS_NR><PLZ>12345</PLZ><ORT>Musterstadt</ORT><STAAT>276</STAAT><GEBURTSDATUM>03.09.1982</GEBURTSDATUM></C55QN01></BWIDATA>'
    @buergel.construct_xml("Hans", "Dampf", "Teststr.", "12A", "12345", "Musterstadt", "de", "03.09.1982").must_equal(answer)
  end

  it "constructs valid request xml with search type" do
    ["00", "01"].each do |search_type|
      Buergel.search_type = search_type
      buergel = Buergel::Base.new()
      answer = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><BWIDATA><HEADER><SYSTEM_CODE>BAS</SYSTEM_CODE><KOMM_METHODE>TS</KOMM_METHODE><KOMM_TIMEOUT_SEKUNDEN>003</KOMM_TIMEOUT_SEKUNDEN><GP_ID>C55QN01</GP_ID><KNDNR>123</KNDNR><KNDFILIALE></KNDFILIALE><TRANSFNK>AN</TRANSFNK><USERID>321</USERID><SEGMENTNAME>C55QN01</SEGMENTNAME><FREMD_USERID></FREMD_USERID><DIALOGSPRACHE>01</DIALOGSPRACHE><XML_MARKUP_KZ>02</XML_MARKUP_KZ><SUCH_ART>#{search_type}</SUCH_ART></HEADER><C55QN01><VERSANDART>6</VERSANDART><ANF_ART>70</ANF_ART><LIEFERSPRACHE>1</LIEFERSPRACHE><KND_KEY1></KND_KEY1><KND_KEY2></KND_KEY2><VORNAME>Hans</VORNAME><NAME1>Dampf</NAME1><STRASSE>Teststr.</STRASSE><HAUS_NR>12A</HAUS_NR><PLZ>12345</PLZ><ORT>Musterstadt</ORT><STAAT>276</STAAT><GEBURTSDATUM>03.09.1982</GEBURTSDATUM></C55QN01></BWIDATA>"
      buergel.construct_xml("Hans", "Dampf", "Teststr.", "12A", "12345", "Musterstadt", "de", "03.09.1982").must_equal(answer)
    end

    Buergel.search_type = nil
  end

  it "raises an exception if the speecified search_type is invalid" do
    previous_value = Buergel.search_type
    ['0', '1', '02'].each do |v|
      assert_raises(Buergel::BuergelException) {Buergel.search_type = v}
      Buergel.search_type.must_equal(previous_value)
    end
  end

  it "accepts nil as valid values for search_type" do
    Buergel.search_type = nil
    Buergel.search_type.must_be_nil
  end

  it "constructs request xml with invlid country" do
    assert_raises(IsoCountryCodes::UnknownCodeError) {@buergel.construct_xml("Hans", "Dampf", "Teststr.", "12A", "12345", "Musterstadt", "unkonw")}
  end

  it "has different url for live and test" do
    Buergel.test_mode = false
    @buergel.get_url.must_equal('https://www.buergel-online.de/rcs/xml.jsp')
    Buergel.test_mode = true
    @buergel.get_url.must_equal('https://www.buergel-online.de/rcstest/xml.jsp')
    Buergel.test_mode = false
  end

end
