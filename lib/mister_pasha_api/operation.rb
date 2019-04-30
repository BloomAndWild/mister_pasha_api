module MisterPashaApi
  class Operation
    VERSION_NUMBER = "1".freeze
    REQUEST_TYPE = "e-com".freeze

    def initialize options = {}
      @options = options
      @params_object = OpenStruct.new(options.fetch(:params, {}))
    end

    def execute
      conn = Faraday.new
      conn.use Faraday::Response::Logger, config.logger, bodies: true
      response = conn.get base_url, payload
      body = JSON.parse(response.body)
      if response.success? && !body.key?("erreur_execution")
        transformed_response(body)
      else
        raise MisterPashaApi::Errors::ResponseError.new(
          delivery_id: params_object.delivery_id,
          message: "#{body['erreur_execution']}",
        )
      end
    end

    def payload
      {}
    end

    def config
      Client.config
    end

    private
    attr_reader :options, :params_object

    def transformed_response body
      body
    end

    def transaction_number
      "#{params_object.delivery_id}#{Time.now.to_i}"
    end

    def base_url
      config.base_url
    end

    def api_key
      config.api_key
    end
  end
end
