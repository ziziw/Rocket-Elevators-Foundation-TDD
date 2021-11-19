require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

class WatsonController < ApplicationController
  def greetings
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: ENV['WATSON_API_KEY']
    )
    text_to_speech = TextToSpeechV1.new(
      authenticator: authenticator
    )
    text_to_speech.service_url = ENV['WATSON_URL']

    numOFInactive = Elevator.where.not(status:"Online").count

    File.open("app/assets/audio/greetings.wav", "wb") do |audio_file|
        response = text_to_speech.synthesize(
          text: "Greetings  #{$current_user_firstname.to_s},
          where are currently #{Elevator.count.to_s} elevators deployed in the #{Building.count.to_s} buildings of your #{Customer.count.to_s} customers.
          Currently,#{numOFInactive.to_s} elevators are not in Online Status and are being serviced.
          You currently have #{Quote.count.to_s} quotes awaiting processing.
          You currently have #{Lead.count.to_s} in your contact requests.
          #{Battery.count.to_s}Batteries are deployed across #{Address.distinct.count(:city).to_s} cities" ,
          
          accept: "audio/wav",
          voice: "en-US_MichaelV3Voice"
        )

        audio_file.write(response.result)
        
    end
  end
end