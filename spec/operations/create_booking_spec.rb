require "spec_helper"

describe MisterPashaApi::Operations::CreateBooking do
  describe "#execute" do
    before do
      configure_client
      allow_any_instance_of(
        described_class
      ).to receive(:transaction_number).and_return(transaction_number)
    end

    context "with valid payload" do
      subject { described_class.new(params: valid_params) }

      let(:valid_params) do
        {
          delivery_id: 3347416,
          shipping_date: "2019-05-01",
          first_name: "Mr",
          last_name: "Testy",
          email: "misterpasha@bloomandwild.com",
          phone: "0975186067",
          address_line1: "Champ de Mars",
          address_line2: "5 Avenue Anatole",
          postcode: "75007",
          city: "Paris",
          company_name: "Bloom and Wild",
        }
      end

      let(:transaction_number) { 422922419144462004613551339887494 }

      it "books delivery" do
        VCR.use_cassette('valid_create_booking_request') do
          response = described_class.new(params: valid_params).execute

          expect(response).to eq(parcel_id: 19440)
        end
      end
    end

    context "with invalid payload" do
      subject { described_class.new(params: invalid_params) }

      let(:invalid_params) do
        {
          # delivery_id is missing
          shipping_date: "2019-05-01",
          first_name: "Mr",
          last_name: "Testy",
          email: "misterpasha@bloomandwild.com",
          phone: "0975186067",
          address_line1: "Champ de Mars",
          address_line2: "5 Avenue Anatole",
          postcode: "75007",
          city: "Paris",
          company_name: "Bloom and Wild",
        }
      end

      let(:transaction_number) { 686742134619421023153735263751768 }

      let(:error_message) { "R\u00e9f\u00e9rence interne de la commande non valide !" }

      it "raises the error" do
        VCR.use_cassette('invalid_create_booking_request') do
          expect {
            described_class.new(params: invalid_params).execute
          }.to raise_exception(MisterPashaApi::Errors::ResponseError, error_message)
        end
      end
    end
  end
end
