module Searches
  class GetSearch
    include Caze

    attr_reader :data_result
    export :call, as: :get_search

    def initialize(params)
      @data   = []
      @meta   = {}
      @errors = []
      @params = params
      @id     = nil
    end

    def call
      begin
        get_search if params_ok?
      rescue => e
        @errors << {error: e}
      end
      @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

    def params_ok?
      form = Searches::GetSearchForm.from_json(params)
      if form.valid?
        @id = form.id
      else
        @errors << form.errors.messages
      end
      return form.valid?
    end

    def get_search
      data_to_append = searches_repository.show_search(id)
      if data_to_append.resource.present?
        @data << searches_repository.show_search(id)
      else
        @errors << {error: 'Search not found'}
      end
    end

    def searches_repository
      @searches_repository ||= Searches::SearchesRepository.new
    end

    def params
      @params
    end

    def id
      @id
    end

  end
end