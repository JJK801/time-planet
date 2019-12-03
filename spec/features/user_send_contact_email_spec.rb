require 'rails_helper'

feature 'contact page' do

  let(:message) { FactoryBot.build(:message) }

  scenario 'user send email successfully' do
    visit contact_path

    fill_in 'message[sender_first_name]', with: message.sender_first_name
    fill_in 'message[sender_last_name]', with: message.sender_last_name
    fill_in 'message[sender_email]', with: message.sender_email
    fill_in 'message[body]', with: message.body
    click_button 'Envoyer'

    expect(page).to have_content('Votre message a bien été envoyé.')
    expect(Message.count).to eq(1)
  end

  scenario 'user cannot submit because of empty first name' do
    visit contact_path

    fill_in 'message[sender_last_name]', with: message.sender_last_name
    fill_in 'message[sender_email]', with: message.sender_email
    fill_in 'message[body]', with: message.body
    click_button 'Envoyer'

    expect(page).to have_content("Veuillez indiquer votre prénom")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(Message.count).to eq(0)
  end

  scenario 'user cannot submit because of empty last name' do
    visit contact_path

    fill_in 'message[sender_first_name]', with: message.sender_first_name
    fill_in 'message[sender_email]', with: message.sender_email
    fill_in 'message[body]', with: message.body
    click_button 'Envoyer'

    expect(page).to have_content("Veuillez indiquer votre nom")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(Message.count).to eq(0)
  end

  scenario 'user cannot submit because of empty email' do
    visit contact_path

    fill_in 'message[sender_first_name]', with: message.sender_first_name
    fill_in 'message[sender_last_name]', with: message.sender_last_name
    fill_in 'message[body]', with: message.body
    click_button 'Envoyer'

    expect(page).to have_content("Veuillez indiquer votre email")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(Message.count).to eq(0)
  end

  scenario 'user cannot submit because of invalid email' do
    visit contact_path

    fill_in 'message[sender_first_name]', with: message.sender_first_name
    fill_in 'message[sender_last_name]', with: message.sender_last_name
    fill_in 'message[sender_email]', with: 'wrong_emailgmail.com'
    fill_in 'message[body]', with: message.body
    click_button 'Envoyer'

    expect(page).to have_content("votre email est incorrect(e)")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(Message.count).to eq(0)
  end

  scenario 'user cannot submit because of empty body' do
    visit contact_path

    fill_in 'message[sender_first_name]', with: message.sender_first_name
    fill_in 'message[sender_last_name]', with: message.sender_last_name
    fill_in 'message[sender_email]', with: message.sender_email
    click_button 'Envoyer'

    expect(page).to have_content("Veuillez indiquer votre message")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(Message.count).to eq(0)
  end

  context 'js validation' do
    scenario 'user should have immediate feedback on input when wrong', js: true do
      visit contact_path

      fill_in 'message[sender_email]', with: 'wrong_email'
      page.find("body").click
      expect(page).to have_content("votre email est incorrect(e)")

      fill_in 'message[sender_email]', with: 'example@ok.com'
      page.find("body").click

      expect(page).not_to have_content("votre email est incorrect(e)")
    end
  end
end
