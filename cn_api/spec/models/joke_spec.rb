require 'rails_helper'

RSpec.describe Joke, type: :model do
  let!(:joke) { create(:joke) }
  # Association test
  # ensure Joke model has a m:m relationship with the Categories and Search models
  it { should have_many(:categories).through(:joke_categories) }
  it { should have_many(:searches).through(:joke_searches) }
  # Validation tests
  it { should validate_uniqueness_of(:ext_id) }
  # it { should validate_presence_of(:ext_id) }
  # it { should validate_presence_of(:joke_value) }
  # it { should validate_presence_of(:joke_url) }
end
