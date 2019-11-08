require 'rails_helper'

describe Project, type: :model do
  it { should have_many(:entrepreneurs) }
  it { should validate_uniqueness_of(:slug)}
  it { should validate_uniqueness_of(:prismic_id)}
  it { should validate_presence_of(:prismic_id) }
end
