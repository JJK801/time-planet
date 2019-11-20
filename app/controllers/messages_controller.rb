class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      MessageMailer.contact(@message).deliver_now
      redirect_to contact_path, notice: 'Votre message a bien été envoyé.'
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:sender_email, :sender_first_name, :sender_last_name, :body)
  end
end
