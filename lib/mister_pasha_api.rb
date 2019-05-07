require 'faraday'

require 'mister_pasha_api/version'
require 'mister_pasha_api/config'
require 'mister_pasha_api/client'

require 'mister_pasha_api/operation'
require 'mister_pasha_api/operations/create_booking'
require 'mister_pasha_api/operations/track_delivery'

require 'mister_pasha_api/errors/response_error'

module MisterPashaApi
  class Error < StandardError; end
end
