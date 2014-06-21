require 'test_flight_client/version'
require 'test_flight_client/api_request'

module TestFlightClient

  def self.build(params = {})
    ApiRequest.new.post('/builds', params)
  end

end
