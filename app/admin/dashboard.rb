# frozen_string_literal: true
#= require chartkick

ActiveAdmin.register_page 'Dashboard' do
  # puts "Dashboard worksss"

  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do

    panel "Text to Speech" do
      $current_user_firstname = current_user.first_name
      puts("current user first name is " + $current_user_firstname)
      watson_controller = WatsonController.new
      watson_controller.greetings
      audio_tag("greetings.wav", autoplay: true, controls: true)
    end

    panel "Go Home" do
      # controller do
      #   before_action do |_|
      #       redirect_to index_path
      #   end
      # end
    end

  end
end
