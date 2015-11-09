class ContactMailer < MailForm::Base
  include Formats

  TOPICS = {
    'justin@eatsforgood.com' => ['Fundraising and Sponsorships', 'Concern or Complaint'],
    'joe@eatsforgood.com' => ['Press and Media', 'Investor Relations'],
    'bismark64@gmail.com' => ['Technical Help and Bug Fixes']
  }

  attribute :name,      validate: true
  attribute :topic,     validate: true
  attribute :email,     validate: EMAIL_REGEX
  attribute :phone
  attribute :message,   validate: true

  def get_recipient
    topic_value = TOPICS.values.select{|t| t.include?(self.topic) }.flatten
    TOPICS.key(topic_value)
  end

  def headers
    {
      subject: "Contact from #{name}",
      from: 'EatsForGood.com <no-reply@eatsforgood.com>',
      to: get_recipient
    }
  end  
end