require "spec_helper"

describe MisterPashaApi::Operations::CancelBooking do
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

      let(:transaction_number) { "33494311558105040" }

      let(:expected_response) do
        {
          completed: "true",
        }
      end

      it "cancels booking" do
        VCR.use_cassette('cancel_booking') do
          response = described_class.new(params: params).execute

          expect(response).to eq(expected_response)
        end
      end
    end

    context "with random parcel ID" do
      let(:params) do
        { parcel_reference: "123453A" }
      end

      let(:transaction_number) { "123453A1558105041" }

      let(:error_message) { "Impossible de retrouver le colis" }

      it "returns error message" do
        VCR.use_cassette('cancel_unknown_booking') do
          expect {
            described_class.new(params: params).execute
          }.to raise_exception(MisterPashaApi::Errors::ResponseError, error_message)
        end
      end
    end
  end
end
