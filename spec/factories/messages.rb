FactoryBot.define do
  factory :message do
    sender_first_name { 'Nicolas' }
    sender_last_name { 'Hulot' }
    sender_email { 'nicolas.hulot@gmail.com' }
    body { "Bonjour, j'aimerais vous donner de l'argent pour vous aider à sauver la planète" }
  end
end
