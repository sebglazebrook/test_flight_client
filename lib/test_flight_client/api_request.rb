require 'httmultiparty'

module TestFlightClient
  class ApiRequest

    include HTTMultiParty
    base_uri 'http://testflightapp.com/api'

    def post(path, params = {})
        self.class.post("#{path}.json", query: formulate_query_params(params))
    end

    private

    def formulate_query_params params
      params.inject({}) do |memo, param|
        if file_based_params.include? param[0].to_sym
          memo[param[0]] = resolve_file(param[1])
        else
          memo[param[0]] = param[1]
        end
        memo
      end
    end

    def file_based_params
      %i(file dsym)
    end

    def resolve_file(param)
      if param.class == File
        param
      else
        begin
          File.new(param, 'r')
        rescue Exception => e
          raise IrresolvableFileParameter.new("Could not create a file from parameter #{param}")
        end
      end
    end

    class IrresolvableFileParameter < Exception ; end
  end
end