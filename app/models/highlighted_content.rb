class HighlightedContent < ApplicationRecord
  belongs_to :project, optional: true

  validates :prismic_id, uniqueness: true, presence: true
  validate :project_exists

  private

  def project_exists
    if !project_id.nil? && Project.where(id: project_id).empty?
      errors.add(:project_id, message: 'Project does not exist in db')
    end
  end
end
