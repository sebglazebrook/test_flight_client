# TestFlightClient

Super simple ruby client for TestFlightApp's super simple developer API.

## Installation

Add this line to your application's Gemfile:

    gem 'test_flight_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test_flight_client

## Usage

    require 'test_flight_client'

    TestFlightClient.build(
        api_token: 'your api token',
        team_token: 'your team token',
        file: 'file path or file object',
        notes: 'whatever notes you want to add'
    )

## Contributing

1. Fork it ( https://github.com/[my-github-username]/test_flight_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
