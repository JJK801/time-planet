require 'rails_helper'

describe Entrepreneur, type: :model do
  it { should belong_to(:project).optional }
  it { should validate_uniqueness_of(:prismic_id)}
  it { should validate_presence_of(:prismic_id) }
end
