require 'securerandom'

module MisterPashaApi
  module Operations
    class FetchTimeSlots < Operation
      ACTION_NAME = "CreneauDisponible".freeze
      VERSION_NUMBER = "4".freeze
      AVAILABLE_SLOT_STATE = "0".freeze

      def payload
        {
          action: ACTION_NAME,
          type: REQUEST_TYPE,
          version: VERSION_NUMBER,
          clef: api_key,
          transaction: transaction_number,
          code_postal: params_object.postcode,
          date_debut: Date.parse(params_object.start_date).strftime("%Y%m%d"),
          date_fin: Date.parse(params_object.end_date).strftime("%Y%m%d"),
          heure_debut: "",
        }
      end

      private

      def transaction_number
        "#{params_object.delivery_id}#{Time.now.to_i}"
      end

      def transformed_response body
        {
          available_time_slots: available_time_slots(body["liste_creneau"]),
        }
      end

      def available_time_slots response
        result = []
        response.each do |delivery_date, slots|
          slots.each do |slot|
            result << TimeSlot.new(slot, delivery_date)
          end
        end
        result
      end
    end
  end
end
