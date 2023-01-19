module Marketing
  def self.send_sms(number)
    require 'twilio-ruby'

    account_sid = ENV['TWILLIO_ACCOUNT_SID']
    auth_token = ENV['TWILLIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+15162615353'
    to = '+40773346603'

    client.messages.create(
      from: from,
      to: to,
      body: "Hey friend!"
    )
  end
end