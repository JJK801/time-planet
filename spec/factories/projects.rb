FactoryBot.define do
  factory :project do
    sequence(:slug) { |n| "slug#{n}" }
    sequence(:prismic_id) { |n| "prismic_id_#{n}" }
    sequence(:title) { |n| "title#{n}" }
    sequence(:meta_title) { |n| "meta_title#{n}" }
    sequence(:meta_description) { |n| "meta_description#{n}" }
    sequence(:description) { |n| "description#{n}" }
    sequence(:cover_image_url) { |n| "http://cover_img_url_#{n}" }
    sequence(:cover_image_alt) { |n| "cover_img_alt_#{n}" }
  end
end
