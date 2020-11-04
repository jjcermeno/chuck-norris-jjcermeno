require 'rails_helper'

RSpec.describe Search, type: :model do
  let!(:search) { create(:search) }
  # Association test
  # ensure Category model has a m:m relationship with the JokeCategories model
  # it { should have_many(:jokes).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:search_type) }
end