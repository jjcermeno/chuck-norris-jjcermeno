require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { create(:category) }
  # Association test
  # ensure Category model has a m:m relationship with the JokeCategories model
  # it { should have_many(:joke_categories).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:category_name) }
  it { should validate_uniqueness_of(:category_name) }
end