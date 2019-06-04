# MisterPashaApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mister_pasha_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mister_pasha_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mister_pasha_api

## Usage

### Configure client

```
MisterPashaApi::Client.configure do |config|
logger = Logger.new(STDERR)
logger.level = :debug

config.base_url = ENV.fetch('BASE_URL')
config.api_key = ENV.fetch('API_KEY')
config.logger = logger
end
```

### Fetch time slots

```
MisterPashaApi::Operations::FetchTimeSlots.new(
  params: {
    postcode: "insert value", # recipient's address postcode
    start_date: "insert value", # start date of time slot range. Ex "2019-06-03".
    end_date: "insert value", # end date of time slot range.Ex "2019-06-04".
  }
).execute
```

The above operation will return array of `TimeSlot` objects.

TimeSlot object support these public methods:

- "slot" - original slot. Ex: "19h00-20h00-0".
- "reference" - slot reference required to book same day delivery. Ex: "19h00-20h00".
- "delivery_date" - date of delivery.
- "local_start_time" - start time of slot (parsed to french time zone).
- "local_end_time" - end time of slot (parsed to french time zone).
- "state" - one of three states: "available", "unavailable", "green".

### Book delivery

```
MisterPashaApi::Operations::CreateBooking.new(
  params: {
    delivery_id: "insert value", # unique delivery identifier
    shipping_date: "insert value", # shipping date
    first_name: "insert value", # recipient's first name
    last_name: "insert value", # recipient's last name
    email: "insert value", # recipient's email
    phone: "insert value", # recipient's phone
    address_line1: "insert value", # recipient's address line 1
    address_line2: "insert value", # recipient's address line 2
    postcode: "insert value", # recipient's address postcode
    city: "insert value", # recipient's address city
    company_name: "insert value", # name of your company
    delivery_date: "insert value", # delivery date (required for same day delivery)
    time_slot_reference: "insert value", # reference to their time slot (required for same day delivery)
  }
).execute
```

The above operation will return the hash with parcel ID:

```
{ parcel_id: xxxxx }
```

### Track delivery

```
MisterPashaApi::Operations::TrackDelivery.new(
  params: {
    parcel_reference: "insert value", # delivery ID / parcel ID can be used.
  }
).execute
```

The above operation will return the hash with status information:

```
{
  status_code: "X", # status code between 1 and 14
  status_message: "Y", # explanatory message if status is 11, 12, 13, 14
  additional_status_details: "Z", # array with additional status details
  identification_number: "W", # identification number of Mister Pasha parcel
  tracking_number: "V", # parcel carrier identifier
}
```

### Cancel booking

```
MisterPashaApi::Operations::CancelBooking.new(
  params: {
    parcel_reference: "insert value", # delivery ID / parcel ID can be used.
  }
).execute
```

The above operation will return the hash with status information:

```
{
  completed: "true"
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mister_pasha_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
