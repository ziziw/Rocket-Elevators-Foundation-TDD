require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

class WatsonController < ApplicationController
  def greetings
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: 'gN7doEbi1hPHXmGiRMUsBGA3K3fB-_l-tgDyRCXq9TOw'
    )
    text_to_speech = TextToSpeechV1.new(
      authenticator: authenticator
    )
    text_to_speech.service_url = 'https://api.us-east.text-to-speech.watson.cloud.ibm.com/instances/aa12f8df-5838-42f8-893c-78f20028ba28'

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

    

    def starwars
      authenticator = Authenticators::IamAuthenticator.new(
        apikey: "gN7doEbi1hPHXmGiRMUsBGA3K3fB-_l-tgDyRCXq9TOw"
      )
      text_to_speech = TextToSpeechV1.new(
        authenticator: authenticator
      )
      text_to_speech.service_url = "https://api.us-east.text-to-speech.watson.cloud.ibm.com"
     
      starwarsfact = ["number 1. Did you know, Michael Jackson Almost Played Jar Jar ?",
          "number 2. Did you know, JarJar Binks Was The First Fully CG Main Character, which helped pioneering the world of motion capture ?",
          "number 3. Did you know, jarjar Binks’ helped to elevate senator Palpatine to Supreme Chancellor ? Was Jarjar binks really a Sith lord ?",
          "number 4. Did you know, Jar-Jar Binks got his name from George Lucas’s young son?",
          "number 5. Did you know, in Episode 1, darth maul only has three line in the entire movie ?",
          "number 6. did you know, Qui-Gon Jinn was added as Obi-Wan’s master to flow with the generational “Passing the Torch” theme found throughout the whole saga?",
          "number 7. Did you know, During the first week of the first trailer’s release, many theaters reported up to 75% of their audiences paying full price for a movie, then walking out after the Star Wars: Episode I trailer was shown?",
          "number 8. Did you know. Before The Phantom Menace, George Lucas had not directed a film since the original Star Wars ?",
          "number 9. Did you know. Anakin's theme is a musical variation on the Imperial March ? ",
          "number 10. Did you know. there was going to be a scene in which Palpatine thanked Binks for granting him the emergency powers that allowed him to take over the galaxy, but it was deleted from the final cut?",
          "number 11. Did you know. Jar Jar Binks was originally designed with green skin ?" ,
          "number 12. Did you know. Samuel L. Jackson got the role of Mace Windu in part through an appearance on the British talk show TFI Friday to promote a different movie ?",
          "number 13. Did you know. in episode 1,The three Wookiees in the Galactic Senate all wore the same Chewbacca costume from the Lucasfilm archive ?",
          "number 14. Did you know. The very first scene of The Phantom Menace that was filmed featured Darth Sidious and Darth Maul.",
          "number 15. Did you know. In the production of episode 1, The jadi and Sith went through three hundred aluminum lightsaber blades while filming The Phantom Menace ?",
          "number 16. Did you know. Some of the cheers and jeers emanating from the audience at the podrace are from a San Francisco forty=niners game ?",
          "number 17. Did you know. During filming, Ewan McGregor made lightsaber noises as he dueled. It was noted and corrected during post production ?",
          "number 18. Did you know. The sound of the underwater monsters growling near the beginning of the film was made by the main sound technician’s three-year-old daughter?",
          "number 19. Did you know. In the first Episode. The word lightsaber is never used in the film. When Anakin talks to Qui-Gon he calls it a “laser sword ?",
          "number 20. Did you know. The starship Enterprise from Star Trek: The Next Generation from 1987, can be seen briefly amongst the traffic flying around Coruscant ?"
          
          
          ]
  
      File.open("app/assets/audio/starwars.wav", "wb") do |audio_file|
          response = text_to_speech.synthesize(
            text: starwarsfact.sample,
            
            accept: "audio/wav",
            voice: "en-US_AllisonV3Voice"
          )
  
          audio_file.write(response.result)
          
      end
  end
end