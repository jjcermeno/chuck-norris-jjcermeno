require 'sinatra/base'

class FakeChuckNorrisApiServer < Sinatra::Base
  get '/jokes/random' do
    if params[:category]
      # puts "INTERCEPTING category"
      json_response 200, 'category.json'
    else
      # puts "INTERCEPTING random"
      json_response 200, 'random.json'
    end
  end

  get '/jokes/categories' do
    # puts "INTERCEPTING categories"
    json_response 200, 'categories.json'
  end

  get '/jokes/search' do
    # puts "INTERCEPTING search"
    json_response 200, 'yes_sir.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'r').read
  end
end
