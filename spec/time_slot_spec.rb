require "spec_helper"

describe MisterPashaApi::TimeSlot do
  subject { described_class.new(slot, delivery_date) }

  let(:slot) { "18h00-19h00-1" }
  let(:delivery_date) { "2019-06-03" }

  describe "#local_start_time" do
    it "returns correct time slot starting time" do
      expect(subject.local_start_time.to_s).to eq(
        "2019-06-03 18:00:00 +0200"
      )
    end

    context "with last time slot" do
      let(:slot) { "23h00-00h00-1" }

      it "returns correct time slot starting time" do
        expect(subject.local_start_time.to_s).to eq(
          "2019-06-03 23:00:00 +0200"
        )
      end
    end
  end

  describe "#local_end_time" do
    it "returns correct time slot ending time" do
      expect(subject.local_end_time.to_s).to eq(
        "2019-06-03 19:00:00 +0200"
      )
    end

    context "with last time slot" do
      let(:slot) { "23h00-00h00-1" }

      it "returns correct time slot ending time" do
        expect(subject.local_end_time.to_s).to eq(
          "2019-06-04 00:00:00 +0200"
        )
      end
    end
  end

  describe "#state" do
    let(:available_slot) { described_class.new("18h00-19h00-0", delivery_date) }
    let(:unavailable_slot) { described_class.new("18h00-19h00-1", delivery_date) }
    let(:green_slot) { described_class.new("18h00-19h00-2", delivery_date) }

    it "returns correct state" do
      expect(available_slot.state).to eq("available")
      expect(unavailable_slot.state).to eq("unavailable")
      expect(green_slot.state).to eq("green")
    end
  end

  describe "#reference" do
    it "returns slot identifier for booking same day deliveries" do
      expect(subject.reference).to eq("18h00-19h00")
    end
  end
end
