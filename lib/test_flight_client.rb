require 'test_flight_client/version'
require 'test_flight_client/api_request'

module TestFlightClient

  def self.build(params = {})
    ApiRequest.new.post('/builds', merged_parameters(params))
  end

  private

  def self.merged_parameters(params)
    config_params.merge(params)
  end

  def self.config_params
    if config_file && File.exists?(config_file)
      YAML::load(ERB.new(File.read(config_file)).result)
    else
      {}
    end
  end

  def self.config_file
    if ENV['BUNDLE_GEMFILE']
      application_root = ENV['BUNDLE_GEMFILE'].gsub('Gemfile', '')
      File.expand_path(File.join(application_root, 'config', 'test_flight.yml'), __FILE__)
    else
      false
    end
  end

end
