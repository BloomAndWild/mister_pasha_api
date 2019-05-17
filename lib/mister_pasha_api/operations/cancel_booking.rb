module MisterPashaApi
  module Operations
    class CancelBooking < Operation
      ACTION_NAME = "SupprimerCommandeRef".freeze

      def payload
        {
          action: ACTION_NAME,
          type: REQUEST_TYPE,
          version: VERSION_NUMBER,
          clef: api_key,
          transaction: transaction_number,
          ref: params_object.parcel_reference,
        }
      end

      private

      def transaction_number
        "#{params_object.parcel_reference}#{Time.now.to_i}"
      end

      def transformed_response body
        { completed: body["succes"] }
      end
    end
  end
end
