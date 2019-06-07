require "spec_helper"

describe MisterPashaApi::Operations::FetchTimeSlots do
  describe "#execute" do
    before do
      configure_client
      allow_any_instance_of(
        described_class
      ).to receive(:transaction_number).and_return(transaction_number)
    end

    let(:transaction_number) { 1559566219 }

    let(:start_date) { "2019-06-03".to_date }
    let(:end_date) { "2019-06-04".to_date }

    let(:params) do
      {
        postcode: "75007",
        start_date: start_date,
        end_date: end_date,
      }
    end

    it "returns time slot list" do
      VCR.use_cassette('fetch_time_slots_request') do
        response = described_class.new(params: params).execute

        slots = response[:available_time_slots]

        expect(slots.count).to eq(13)
        expect(slots).to all(be_an(MisterPashaApi::TimeSlot))
      end
    end
  end
end
