module MisterPashaApi
  module Errors
    class ResponseError < StandardError
      attr_accessor :delivery_id

      def initialize(args)
        @delivery_id = args[:delivery_id]

        super(args[:message])
      end
    end
  end
end
