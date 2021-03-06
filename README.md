# Infobeep

Ruby Gem for [InfoBip SMS Services](https://dev.infobip.com/getting-started)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'infobeep'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infobeep

## Usage

```ruby
# Create Client
infobeep_client = Infobeep::Client.new('username', 'password')

# Create Request
infobeep_log_request = Infobeep::SMSLogRequest.new
infobeep_log_request.bulkId = 'id_of_bulk_sms_to_fetch_logs_for'

# Send Request and get response
log_request_response = infobeep_client.send_request(infobeep_log_request)
```

###  Supported Request Types
```ruby
Infobeep::SMSRequest # Send a single message to several mobie numbers
Infobeep::BulkSMSRequest # Send multiple messages to multiple phone numbers
Infobeep::SMSLogRequest # Get sent SMS Logs
Infobeep::SMSReportRequest # Get SMS Delivery Reports
Infobeep::AccountBalanceRequest # Get account balance
```


### Example: Send bulk SMS

```ruby
infobeep_client = Infobeep::Client.new('username', 'password')

destinations = []
unique_id = 0
get_sms_message_recipients.each do |recipient|
    unique_id++
    infobeep_destination = Infobeep::SMSRequestDestination.new
    infobeep_destination.messageId = unique_id # leave blank to have Infobip API generate ID
    infobeep_destination.to = recipient.mobile_number
    destinations << infobeep_destination
end

infobeep_msg_request = Infobeep::SMSRequest.new
infobeep_msg_request.from = 'Sender Name'
infobeep_msg_request.text = 'Hello World!'
infobeep_msg_request.intermediateReport = true # Send intermediate delivery report updates
infobeep_msg_request.notifyUrl = 'https://www.bluebic.com/' # callback URL to receive intermediate delivery update
infobeep_msg_request.callbackData = {username: 'kheiron', token: SecureRandom.uuid}.to_json # data to append to delivery report updates
infobeep_msg_request.destinations = destinations

# send simple message
sms_request_response = infobeep_client.send_request(infobeep_msg_request)

# we can also create and send a Bulk SMS Request
infobeep_bulk_msg_request = Infobeep::BulkSMSRequest.new
infobeep_bulk_msg_request.bulkId = 'unique_id_for_message_group' # leave blank to have Infobip API generate
infobeep_bulk_msg_request.messages = [infobeep_msg_request] # Array of Infobeep::SMSRequest

bulk_sms_request_response = infobeep_client.send_request(infobeep_bulk_msg_request)

```

### More Info
The code is simple to read and understand so that it also serves as documentaion. 

For more Info see:

* Request classes: https://github.com/favour121/infobeep/tree/master/lib/infobeep/requests<br/>
Request classes contain all supported request types.

* Model Classes: https://github.com/favour121/infobeep/blob/master/lib/infobeep/models.rb<br/>
Model classes contain all payload (request params) and response data types.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/favour121/infobeep. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

