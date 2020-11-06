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
        perform_jokes_search
        process_jokes
        save_jokes
        save_search
      rescue => e
        @errors << {error: e}
        return DataResult.new(data: [], meta: @meta, errors: @errors)
      end
      @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

    def params_ok?
      @form = Searches::CreateSearchForm.from_json(params)
      @errors << form.errors.messages unless form.valid?
      return form.valid?
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
        puts remote_joke.as_json
        joke_dto = Jokes::JokeDto.from_json(remote_joke)
        next unless joke_dto.valid?
        if joke_exists?
          link_joke_to_search
        else
          create_new_joke
        end
      end
    end

    def save_jokes

    end

    def save_search

    end

    def get_search_data

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

    def cn_api
      @cn_api ||= ApiWrappers::ChuckNorrisApi::Client.new
    end

    def searches_repository
      @searches_repository ||= Searches::SearchesRepository.new
    end

    def joke_exists?
      false
    end

    def link_joke_to_search

    end

    def create_new_joke

    end

  end
end