require 'rails_helper'

RSpec.describe Offer, type: :model do
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code) }
end
