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

    attr_reader :slot, :delivery_date

    def initialize slot, delivery_date
      @slot = slot
      @delivery_date = delivery_date
    end

    def state
      STATES[slot[-1]]
    end

    def local_start_time
      DateTime.parse(delivery_date).in_time_zone(PARIS_TIME_ZONE).change(
        hour: start_hour, min: start_minute, sec: 0
      )
    end

    def local_end_time
      DateTime.parse(delivery_date_for_end_time).in_time_zone(PARIS_TIME_ZONE).change(
        hour: end_hour, min: end_minute, sec: 0
      )
    end

    def reference
      slot[0..10]
    end

    private

    def delivery_date_for_end_time
      start_hour.to_i < end_hour.to_i ? delivery_date : next_delivery_date
    end

    def next_delivery_date
      Date.parse(delivery_date).tomorrow.to_s
    end

    def start_hour
      slot[0..1]
    end

    def end_hour
      slot[6..7]
    end

    def start_minute
      slot[3..4]
    end

    def end_minute
      slot[9..10]
    end
  end
end
