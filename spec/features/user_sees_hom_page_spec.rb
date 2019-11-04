require 'rails_helper'

feature 'user sees home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content("Nous rassemblons 1 milliard d'euros")
  end
end