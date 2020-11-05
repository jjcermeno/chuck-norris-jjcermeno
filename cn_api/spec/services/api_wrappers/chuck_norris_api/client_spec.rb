describe ApiWrappers::ChuckNorrisApi::Client do
  context 'get categories ' do
    it 'total categories count is 16' do
      client = ApiWrappers::ChuckNorrisApi::Client.new
      result = client.get_categories
      expect(result.size).to eq(16)
    end
    it 'categories include animal' do
      client = ApiWrappers::ChuckNorrisApi::Client.new
      result = client.jokes_by_category('animal')
      expect(result['categories']).to include('animal')
    end
  end

  context 'get random ' do
    it 'the random joke id is q3pG5oY-SMOhgah3n_ErLw' do
      client = ApiWrappers::ChuckNorrisApi::Client.new
      result = client.joke_random
      expect(result['id']).to eq('q3pG5oY-SMOhgah3n_ErLw')
    end
  end

  context 'search yessir ' do
    it 'the joke contains yessir' do
      client = ApiWrappers::ChuckNorrisApi::Client.new
      result = client.jokes_by_search_word('yessir')
      expect(result['value']).to include('yessir')
    end
  end
end
