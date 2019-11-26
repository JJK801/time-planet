FactoryBot.define do
  factory :highlighted_content do
    project
    sequence(:prismic_id) { |n| "prismic_id_#{n}" }
  end
end
