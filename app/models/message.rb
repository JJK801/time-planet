class Message < ApplicationRecord
  validates :sender_first_name, presence: true
  validates :sender_last_name, presence: true
  validates :sender_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :body, presence: true
  validates_inclusion_of :interested_to_invest, in: [true, false]
end
