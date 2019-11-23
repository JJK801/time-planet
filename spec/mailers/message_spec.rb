require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe 'contact' do

    let(:message) { FactoryBot.build(:message) }
    let(:mail) { MessageMailer.contact(message) }

    it "should have the right subject" do
      expect(mail.subject).to eq("#{message.sender_first_name} #{message.sender_last_name} depuis time-planet.com")
    end

    it "should send the email the right address" do
      expect(mail.to).to eq(["mehdi@time-planet.com"])
    end

    it "should be sent from the sender address" do
      expect(mail.from).to eq([message.sender_email])
    end

    it "should render the body from the contact page" do
      expect(mail.body.encoded).to match(message.body)
    end

    it 'should send 1 email' do
      expect { mail.deliver_now }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
