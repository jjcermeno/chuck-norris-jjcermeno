require 'rails_helper'

RSpec.describe 'Info API', type: :request do
  # initialize test data
  # let!(:categories) { create_list(:categories, 10) }
  # let(:category_id) { categories.first.id }
  let(:expected_response) {
      {
      "data": [
              {
              "name":             'Chuck Norris Joke Service',
              "version":          '0.0.1',
              "total_categories": 0,
              "total_searches":   0,
              "total_jokes":      0
              }
              ],
      "meta": {},
      "errors": []
    }.as_json
  }

  # Test suite for GET /categories
  describe 'GET /api/v1/info' do
    # make HTTP get request before each example
    before { get '/api/v1/info' }

    it 'returns info info' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json).to eq(expected_response)
    end

    it 'returns info code 200' do
      expect(response).to have_http_status(200)
    end
  end

end