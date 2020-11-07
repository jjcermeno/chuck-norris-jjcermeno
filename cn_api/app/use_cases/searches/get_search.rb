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
      form.valid?
    end

    def calculate_pages
      default_page_size   = 5
      default_page_number = 1
      min_page_size       = 1
      min_page_number     = 1
      max_page_size       = 100
      page_size           = params['pageSize'].present? ? params['pageSize'].to_i : default_page_size
      page_size           = max_page_size if page_size > max_page_size
      page_size           = min_page_size if page_size.negative?
      page_number         = params['pageNumber'].present? ? params['pageNumber'].to_i : default_page_number
      page_number         = min_page_number if page_number.negative?
      @page               = page_number
      @per_page           = page_size
    end

    def get_search
      calculate_pages
      @search = searches_repository.get_search(id)
      if search.present?
        create_metadata
        @data << searches_repository.show_search(id, @meta.dup)
      else
        @errors << {error: 'Search not found'}
      end
    end

    def create_metadata
      @meta[:totalJokes] = search.jokes.size
      @meta[:totalPages] = (@meta[:totalJokes] / per_page) + 1
      @page = @meta[:totalPages] if page > @meta[:totalPages]
      @meta[:pageNumber] = page
      @meta[:pageSize] = per_page
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

    def page
      @page
    end

    def per_page
      @per_page
    end

    def search
      @search
    end


  end
end