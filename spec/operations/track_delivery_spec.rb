require "spec_helper"

describe MisterPashaApi::Operations::TrackDelivery do
  describe "#execute" do
    before do
      configure_client
      allow_any_instance_of(
        described_class
      ).to receive(:transaction_number).and_return(transaction_number)
    end

    subject { described_class.new(params: params) }

    context "with valid parcel ID" do
      let(:params) do
        { parcel_reference: 3349431 }
      end

      let(:transaction_number) { 33494311557245008 }

      let(:expected_response) do
        {
          status_code: "1", # 1 - Not yet received
          status_message: "",
          additional_status_details: [["07/05/2019 à 11h57", "Pas encore réceptionné", "-"]],
          identification_number: nil,
          tracking_number: nil,
        }
      end

      it "returns tracking information" do
        VCR.use_cassette('track_delivery') do
          response = described_class.new(params: params).execute

          expect(response).to eq(expected_response)
        end
      end
    end

    context "with random parcel ID" do
      let(:params) do
        { parcel_reference: "123453A" }
      end

      let(:transaction_number) { 1557237273 }

      let(:error_message) { "Colis inconnu" }

      it "returns error message" do
        VCR.use_cassette('track_unknown_delivery') do
          expect {
            described_class.new(params: params).execute
          }.to raise_exception(MisterPashaApi::Errors::ResponseError, error_message)
        end
      end
    end
  end
end
