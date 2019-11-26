require 'rails_helper'

describe Project, type: :model do
  it { is_expected.to have_many(:entrepreneurs) }
  it { is_expected.to validate_uniqueness_of(:slug)}
  it { is_expected.to validate_uniqueness_of(:prismic_id)}
  it { is_expected.to validate_presence_of(:prismic_id) }
end
