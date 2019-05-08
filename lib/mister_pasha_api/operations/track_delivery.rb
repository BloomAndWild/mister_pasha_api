module MisterPashaApi
  module Operations
    class TrackDelivery < Operation
      ACTION_NAME = "Suivi".freeze

      def payload
        {
          action: ACTION_NAME,
          type: REQUEST_TYPE,
          version: VERSION_NUMBER,
          clef: api_key,
          transaction: transaction_number,
          num_colis: params_object.parcel_reference,
        }
      end

      private

      def transaction_number
        "#{params_object.parcel_reference}#{Time.now.to_i}"
      end

      def transformed_response body
        {
          status_code: body["status"],
          status_message: body["message_erreur"],
          additional_status_details: body["colis_detail"],
          identification_number: body["numero_pasha"],
          tracking_number: body["numero_tracking"],
        }
      end
    end
  end
end
