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
      search.jokes.each do |joke|
        joke.id = initial_index
        joke.save
        initial_index += 1
      end
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
      before { get '/api/v1/searches?pageSize=2' }
      it 'returns searches for pageSize 2' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(2)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with page_number = 2' do
      before { get '/api/v1/searches?pageNumber=2' }
      it 'returns searches for pageNumber default pageNumber' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with page_number = 3' do
      before { get '/api/v1/searches?pageNumber=3' }
      it 'returns searches for pageNumber = 3' do
        expect(json).not_to be_empty
        expect(json["data"].size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with pageNumber = 2 and pageSize = 3' do
      before { get '/api/v1/searches?pageNumber=2&pageSize=3' }
      it 'returns searches for pageNumber = 2 and pageSize = 3' do
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
      let(:search_id) { 987654321123456789 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Search not found/)
      end
    end
  end

  describe 'GET /api/v1/searches/:id?page_number=2&page_size=3' do
    before { get "/api/v1/searches/#{search_id}?pageNumber=2&pageSize=3" }

    context 'when the record exists and paginating resulting jokes' do
      it 'returns the search' do
        expect(json).not_to be_empty
        expect(json["data"].first["id"]).to eq(search_id)
        expect(json["meta"]["totalJokes"]).to eq(0)
        expect(json["meta"]["totalPages"]).to eq(1)
        expect(json["meta"]["pageNumber"]).to eq(1)
        expect(json["meta"]["pageSize"]).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  end

  # Test suite for POST /api/v1/searches
  describe 'POST /api/v1/searches' do
    # valid payload
    let(:valid_attributes_word) {
      {
      searchType:  'WoRd',
      searchValue: 'yessir',
      email:       'jjcerpo@gmail.com'
      }
    }

    context 'when the request is valid using word' do
      before { post '/api/v1/searches', params: valid_attributes_word }

      it 'creates a search' do
        expect(json['data'].first['searchType']).to eq('word')
        expect(json['data'].first['searchValue']).to eq('yessir')
        expect(json['data'].first['email']).to eq('jjcerpo@gmail.com')
        expect(json['data'].first['totalJokes']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    let(:valid_attributes_category) {
      {
      searchType:  'cAtegory',
      searchValue: 'animal',
      email:       'jjcerpo@gmail.com'
      }
    }

    context 'when the request is valid using category' do
      before { post '/api/v1/searches', params: valid_attributes_category }

      it 'creates a search' do
        expect(json['data'].first['searchType']).to eq('category')
        expect(json['data'].first['searchValue']).to eq('animal')
        expect(json['data'].first['email']).to eq('jjcerpo@gmail.com')
        expect(json['data'].first['totalJokes']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    let(:valid_attributes_random) {
      {
      searchType: 'ranDOm',
      email:      'jjcerpo@gmail.com'
      }
    }

    context 'when the request is valid using random' do
      before { post '/api/v1/searches', params: valid_attributes_random }

      it 'creates a search' do
        expect(json['data'].first['searchType']).to eq('random')
        expect(json['data'].first['email']).to eq('jjcerpo@gmail.com')
        expect(json['data'].first['totalJokes']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid because of email' do
      before { post '/api/v1/searches', params: {searchType: 'random', email: 'jjcerpo-gmail.com'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['errors'].to_s).to match(/invalid/)
      end
    end

    context 'when the request is invalid because of wrong search_type' do
      before { post '/api/v1/searches', params: {searchType: 'bad_search_type'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['errors'].to_s)
        .to match(/are allowed/)
      end
    end

    context 'when the request is invalid because of search_type with empty search_value' do
      before { post '/api/v1/searches', params: {searchType: 'woRd'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['errors'].to_s).to match(/can't be blank/)
      end
    end
  end

  # describe 'GET /api/v1/searches/:id/resend_email' do
  #   let!(:search_email) { build(:search_with_email) }
  #   let!(:search_no_email) { build(:search_with_no_email) }
  #   before { get "/api/v1/searches/#{search_email.id}/resend_email" }
  #   context 'when the search exists and it has valid email' do
  #     it 'resends the email' do
  #       expect(json).not_to be_empty
  #       expect(json["data"].first.key?"id").to eq(true)
  #       expect(json["data"].first.key?"totalJokes").to eq(true)
  #     end
  #
  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end
  #   end
  #
  #   before { get "/api/v1/searches/#{search_no_email.id}/resend_email" }
  #   context 'when the search exists and it has not email' do
  #     it 'returns error' do
  #       expect(json).not_to be_empty
  #       expect(json['errors'].to_s).to match(/no email/)
  #     end
  #
  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end
  #   end
  # end

end
