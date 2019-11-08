class Entrepreneur < ApplicationRecord
  validates :prismic_id, uniqueness: true, presence: true

  belongs_to :project, optional: true
end
