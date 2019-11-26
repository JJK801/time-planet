require 'rails_helper'

describe Entrepreneur, type: :model do
  it { is_expected.to belong_to(:project).optional }
  it { is_expected.to validate_uniqueness_of(:prismic_id)}
  it { is_expected.to validate_presence_of(:prismic_id) }
end
