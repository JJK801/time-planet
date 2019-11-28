require 'rails_helper'

describe AssociatesUpdate, type: :model do
  it { is_expected.to validate_presence_of(:total_raised) }
  it { is_expected.to validate_presence_of(:total_associates) }
end
