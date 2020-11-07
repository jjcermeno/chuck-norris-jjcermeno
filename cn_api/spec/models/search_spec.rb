require 'rails_helper'

RSpec.describe Search, type: :model do
  let!(:search) { create(:search) }
  # Association test
  # ensure Search model has a m:m relationship with the Joke model
  it { should have_many(:jokes).through(:joke_searches) }
  # Validation tests
  # it { should validate_presence_of(:search_type) }
end