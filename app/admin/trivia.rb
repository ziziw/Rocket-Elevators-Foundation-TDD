ActiveAdmin.register_page "Trivia" do


    content do
        panel "Star wars EP1 trivia" do
            watson_controller = WatsonController.new
            watson_controller.starwars
            audio_tag("starwars.wav",autoplay: false , controls: true)
        end
    end
end