require 'rails_helper'

describe HighlightedContent, type: :model do
  it { is_expected.to belong_to(:project).optional }
  it { is_expected.to validate_uniqueness_of(:prismic_id)}
  it { is_expected.to validate_presence_of(:prismic_id) }

  it 'should not be valid if project_id does not belongs to project in db' do
    project = FactoryBot.build(:highlighted_content, project_id: 'fake_project_id')

    expect(project.valid?).to be false

    expect(project.errors.messages[:project_id]).to eq([{:message=>"Project does not exist in db"}])
  end
end
