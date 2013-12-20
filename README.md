# Buergel

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'buergel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buergel

## Configuration

Add an initializer:

    Buergel.customer_no = 'YOUR KNDNR'
    Buergel.user_id = 'YOUR USERID'
    Buergel.password = 'YOUR PASSWORD'
    Buergel.test_mode = true #to enable test mode
    Buergel.search_type = '00' or '01'

Alternatively, add the following parameter to your ENV variable:

  BUERGEL_CUSTOMER_NO
  BUERGEL_USER_ID
  BUERGEL_PASSWORD
  BUERGEL_TEST_MODE


## Usage

####Create a new Buergel Instance:

  buergel = Buergel::ConCheckBasic.new

you may change the response language using:

  buergel.set_lang ('de', 'en', 'fr', 'es', 'it')

####Make a boni check:

  response = buergel.request(first_name, last_name, street, street_no, zip, city, country_code, birthdate)

country_code can be alpha2, alpha3, iso-numeric

####As an result you get a Buergel::Response

  response.score Float between 1.0 and 6.0

  response.note A human readable reson for the score
  
  response.first_name … the response also contains the corrected address and the 'ret_code' telling you wether the address was corrected or not


## Future

Right now the gem only implements the ConCheckBasic, for the future more Buergel products could be included 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
