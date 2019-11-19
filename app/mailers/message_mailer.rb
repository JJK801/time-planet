class MessageMailer < ApplicationMailer

  def contact(message)
    @body = message.body

    mail to: 'mehdi@time-planet.com',
         from: message.sender_email,
         subject: "#{message.sender_first_name} #{message.sender_last_name} depuis time-planet.com"
  end
end
