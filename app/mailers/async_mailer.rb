class AsyncMailer < ApplicationMailer
  include Resque::Mailer
end