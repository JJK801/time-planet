# Preview all emails at http://localhost:3000/rails/mailers/contact
class MessagePreview < ActionMailer::Preview
  message = FactoryBot.create(:message)
  MessageMailer.contact(message)
end
