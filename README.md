# Buergel

This gem allows you to call ConCheck basic and ConCheck move requests on the Buergel Scoring API.

## Installation

Add this line to your application's Gemfile:

    gem 'buergel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buergel

## Configuration

Assuming you are using Rails:
Add an initializer config/initializers/buergel.rb:

    Buergel.customer_no = 'YOUR KNDNR'
    Buergel.user_id = 'YOUR USERID'
    Buergel.password = 'YOUR PASSWORD'
    Buergel.test_mode = true #to enable test mode
    Buergel.search_type = '00' or '01'

Alternatively, add the following ENV variables:

    BUERGEL_CUSTOMER_NO
    BUERGEL_USER_ID
    BUERGEL_PASSWORD
    BUERGEL_TEST_MODE

## Usage

### ConCheck basic

####Create a new Buergel::ConCheckBasic instance:

    buergel = Buergel::ConCheckBasic.new

you may change the response language using:

    buergel.set_lang('de', 'en', 'fr', 'es', 'it')

####Make a boni check:

    response = buergel.request(first_name, last_name, street, street_no, zip, city, country_code, birthdate)

country_code can be alpha2, alpha3, iso-numeric

####As an result you get a Buergel::Response

    response.score Float between 1.0 and 6.0
    response.note A human readable reson for the score
    response.first_name … the response also contains the corrected address and the 'ret_code' telling you wether the address was corrected or not

### ConCheck move

ConCheck move differs from ConCheck basic by using additional external data sources to calculate the scoring value.

####Create a new Buergel::ConCheckMove instance:

    buergel = Buergel::ConCheckBasic.new

you may change the response language using:

    buergel.set_lang('de', 'en', 'fr', 'es', 'it')

####Make a boni check:

    response = buergel.request(first_name, last_name, street, street_no, zip, city, country_code, birthdate)

country_code can be alpha2, alpha3, iso-numeric

####As an result you get a Buergel::Response

    response.score Float between 1.0 and 6.0
    response.note A human readable reson for the score
    response.first_name … the response also contains the corrected address and the 'ret_code' telling you wether the address was corrected or not


## Future

Right now the gem only implements ConCheckBasic and ConCheckMove. For the future, more Buergel products could be included.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request