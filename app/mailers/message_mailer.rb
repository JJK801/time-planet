class MessageMailer < ApplicationMailer

  def contact(message)
    @body = message.body

    mail to: 'francois@nada.computer',
         from: message.sender_email,
         subject: "#{message.sender_first_name} #{message.sender_last_name} depuis time-planet.com"
  end
end
