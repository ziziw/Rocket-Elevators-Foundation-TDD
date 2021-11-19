require "slack-notifier"

class Elevator < ApplicationRecord
  belongs_to :column
  before_update :slack_notifier_messsage

  def slack_notifier_messsage
    if self.status_changed?
      notifier = Slack::Notifier.new ENV['SLACK_NOTIFIER']
      notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_was} to #{self.status}"
    end
  end
  
  after_save :verifyIntervention , if: :saved_change_to_status?

  private
  def verifyIntervention
    if self.status.to_s == "Intervention"
      # Download the helper library from https://www.twilio.com/docs/ruby/install
      require 'rubygems'
      require 'twilio-ruby'

      # Find your Account SID and Auth Token at twilio.com/console
      # and set the environment variables. See http://twil.io/secure
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_TOKEN']
      @client = Twilio::REST::Client.new(account_sid, auth_token)


      from = ENV['TWILIO_NUM'] # Your Twilio number
      to = ENV['PERSONAL_NUM'] # Your mobile phone number


      @client.messages.create(
        from: from,
        to: to,
        body: "Please contact your branch for further instructions. Maintenance is needed for  Elevator #"
        )
      end
    end
  
  def to_s
    "Elevator #" + self.id.to_s
  end

end
