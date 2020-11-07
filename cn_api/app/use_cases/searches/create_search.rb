module Searches
  class CreateSearch
    include Caze

    attr_reader :data_result
    export :call, as: :create_search

    def initialize(params)
      @data   = []
      @meta   = {}
      @errors = []
      @params = params
    end

    def call
      begin
        raise StandardError.new "Input data not valid" unless params_ok?
        create_search
        perform_jokes_search
        process_jokes
      rescue => e
        @errors << {error: e}
        return DataResult.new(data: [], meta: @meta, errors: @errors)
      end
      Manager.get_search({id: @id})
      # @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

    def params_ok?
      @form = Searches::CreateSearchForm.from_json(params)
      @errors << form.errors.messages unless form.valid?
      form.valid?
    end

    def create_search
      @search = searches_repository.create_search(form)
      @id = search.id
      @data = [{id: @id}]
    end

    def perform_jokes_search
      @remote_jokes = []
      case form.search_type
      when 'word'
        @remote_jokes = cn_api.jokes_by_search_word(form.search_value)['result']
      when 'category'
        @remote_jokes << cn_api.jokes_by_category(form.search_value)
      when 'random'
        @remote_jokes << cn_api.joke_random
      end
      @remote_jokes.flatten!
    end

    def remote_jokes
      @remote_jokes
    end

    def process_jokes
      remote_jokes.each do |remote_joke|
        joke_form = Jokes::JokeForm.from_json(remote_joke)
        next unless joke_form.valid?
        joke = jokes_repository.find_or_create(joke_form)
        add_joke_to_search(joke)
      end
    end

    def add_joke_to_search(joke)
      search.jokes << joke
      search.jokes = search.jokes.uniq
      search.save
    end

    def cn_api
      @cn_api ||= ApiWrappers::ChuckNorrisApi::Client.new
    end

    def searches_repository
      @searches_repository ||= Searches::SearchesRepository.new
    end

    def jokes_repository
      @jokes_repository ||= Jokes::JokesRepository.new
    end

    def params
      @params
    end

    def id
      @id
    end

    def form
      @form
    end

    def search
      @search
    end

  end
end