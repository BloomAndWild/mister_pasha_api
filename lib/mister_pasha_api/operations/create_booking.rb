require 'securerandom'

module MisterPashaApi
  module Operations
    class CreateBooking < Operation
      ACTION_NAME = "NouvelleCommande".freeze

      def payload
        {
          action: ACTION_NAME,
          type: REQUEST_TYPE,
          version: VERSION_NUMBER,
          clef: api_key,
          transaction: transaction_number,
          cmd_ref_cmd: params_object.delivery_id,
          cmd_nom_cmd: params_object.company_name,
          cmd_date_exp: params_object.shipping_date.to_date.strftime("%Y%m%d"),
          dest_nom: params_object.last_name,
          dest_prenom: params_object.first_name,
          dest_email: params_object.email,
          dest_tel: params_object.phone,
          dest_addr_1: params_object.address_line1,
          dest_addr_2: params_object.address_line2,
          dest_addr_3: params_object.address_line3 || "",
          dest_addr_4: params_object.address_line4 || "",
          dest_cp: params_object.postcode,
          dest_ville: params_object.city,
          cmd_date_liv: delivery_date,
          cmd_creneau_liv: params_object.time_slot_reference || "",
          # API requires to pass all the attributes even if they are not used.
          cmd_ref_transporteur: "",
          cmd_ref_prod: "",
          cmd_num_colis: "",
          cmd_poids: "",
          cmd_transporteur: "",
        }
      end

      private

      def delivery_date
        params_object.delivery_date ?
          Date.parse(params_object.delivery_date).strftime("%Y%m%d") : ""
      end

      def transaction_number
        "#{params_object.delivery_id}#{Time.now.to_i}"
      end

      def transformed_response body
        { parcel_id: body["id_colis"] }
      end
    end
  end
end
