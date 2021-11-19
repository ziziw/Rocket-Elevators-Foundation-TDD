# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@jasminekaur.link'
  layout 'mailer'
end
