module MisterPashaApi
  class TimeSlot
    PARIS_TIME_ZONE = "Europe/Paris".freeze
    AVAILABLE = "available".freeze
    UNAVAILABLE = "unavailable".freeze
    GREEN = "green".freeze

    STATES = {
      "0" => AVAILABLE,
      "1" => UNAVAILABLE,
      "2" => GREEN,
    }

    def initialize slot, delivery_date
      @slot = slot
      @delivery_date = delivery_date
    end

    def state
      STATES[slot[-1]]
    end

    def local_start_time
      DateTime.parse(delivery_date).in_time_zone(PARIS_TIME_ZONE).change(
        hour: slot[0..1], min: slot[3..4], sec: 0
      )
    end

    def local_end_time
      DateTime.parse(delivery_date).in_time_zone(PARIS_TIME_ZONE).change(
        hour: slot[6..7], min: slot[9..10], sec: 0
      )
    end

    def reference
      slot[0..10]
    end

    private
    attr_reader :slot, :delivery_date
  end
end
