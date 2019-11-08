FactoryBot.define do
  factory :entrepreneur do
    project
    sequence(:prismic_id) { |n| "prismic_id_#{n}" }
    sequence(:name) { |n| "name#{n}" }
    sequence(:position) { |n| "position#{n}" }
    sequence(:description) { |n| "description#{n}" }
    sequence(:picture_url) { |n| "http://picture_url_#{n}" }
    sequence(:picture_alt) { |n| "picture_alt_#{n}" }
  end
end
