require 'rails_helper'

describe Message, type: :model do
  it { is_expected.to validate_presence_of(:sender_email) }
  it { is_expected.to validate_presence_of(:sender_first_name) }
  it { is_expected.to validate_presence_of(:sender_last_name) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to allow_value('test@example.com').for(:sender_email) }
  it { is_expected.not_to allow_value('fake_email.com').for(:sender_email) }
end
