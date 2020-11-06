require 'rails_helper'

RSpec.describe 'Searches API', type: :request do

  # initialize test data
  let!(:searches) { create_list(:search, 12) }
  let!(:run_code) {
    initial_index = (1..1000).to_a.shuffle.sample
    searches.each do |search|
      search.id = initial_index
      search.save
      initial_index += 1
    end
  }
  let!(:search_id) { searches.first.id }

  # Test suite for GET /api/v1/searches
  describe 'GET /api/v1/searches' do

    context 'no page params' do
      before { get '/api/v1/searches' }
      it 'returns searches' do
        expect(json).not_to be_empty
        #default items per page
        expect(json["data"].size).to eq(5)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with page_size = 2' do
      before { get '/api/v1/searches?page_size=2' }
      it 'returns searches for page_size 2' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(2)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with page_number = 2' do
      before { get '/api/v1/searches?page_number=2' }
      it 'returns searches for page_number default page_number' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with page_number = 3' do
      before { get '/api/v1/searches?page_number=3' }
      it 'returns searches for page_number = 3' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with page_number = 2 and page_size = 3' do
      before { get '/api/v1/searches?page_number=2&page_size=3' }
      it 'returns searches for page_number = 2 and page_size = 3' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /api/v1/searches:id
  describe 'GET /api/v1/searches/:id' do
    before { get "/api/v1/searches/#{search_id}" }

    context 'when the record exists' do
      it 'returns the search' do
        expect(json).not_to be_empty
        expect(json["data"].first["id"]).to eq(search_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:search_id) { 987654321123456789  }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Search not found/)
      end
    end
  end

  # Test suite for POST /api/v1/searches
  describe 'POST /api/v1/searches' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/api/v1/searches', params: valid_attributes }

      xit 'creates a search' do
        expect(json['title']).to eq('Learn Elm')
      end

      xit 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/searches', params: { title: 'Foobar' } }

      xit 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      xit 'returns a validation failure message' do
        expect(response.body)
        .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

end