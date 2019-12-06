class AssociatesUpdate < ApplicationRecord
  validates :total_raised, presence: true
  validates :total_associates, presence: true

  def step_percentage
    if total_raised / 300000.0 * 100 < 0.5
      0.5
    else
      total_raised / 300000.0 * 100
    end
  end
end
