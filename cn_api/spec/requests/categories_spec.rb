require 'rails_helper'

RSpec.describe 'Categories API', type: :request do

  # Test suite for GET /categories
  describe 'GET /api/v1/categories' do
    # make HTTP get request before each example
    before { get '/api/v1/categories' }

    it 'returns categories' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(16)
      json['data'].each do |item|
        expect(item).to have_key("id")
        expect(item).to have_key("categoryName")
        expect(item).to have_key("createdAt")
        expect(item).to have_key("updatedAt")
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end