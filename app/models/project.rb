class Project < ApplicationRecord
  validates :slug, uniqueness: true
  validates :prismic_id, uniqueness: true, presence: true

  has_many :entrepreneurs
end
