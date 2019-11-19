require 'rails_helper'

describe Message, type: :model do
  it { should validate_presence_of(:sender_email) }
  it { should validate_presence_of(:sender_first_name) }
  it { should validate_presence_of(:sender_last_name) }
  it { should validate_presence_of(:body) }
  it { should allow_value('test@example.com').for(:sender_email) }
  it { should_not allow_value('fake_email.com').for(:sender_email) }
end
