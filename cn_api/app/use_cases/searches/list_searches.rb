module Searches
  class ListSearches
    include Caze

    attr_reader :data_result
    export :call, as: :list_searches

    def initialize(params)
      @data   = []
      @meta   = {}
      @errors = []
      @params = params
    end

    def call
      begin
        calculate_pages
        get_searches
      rescue => e
        @errors << {error: e}
      end
      @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

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

    def get_searches
      @meta[:totalSearches] = searches_repository.total_searches
      @meta[:totalPages] = (@meta[:totalSearches] / per_page) + 1
      @meta[:pageNumber] = page
      @meta[:pageSize] = per_page
      searches_data = searches_repository.get_searches_page(page, per_page)
      @data = searches_repository.show_searches(searches_data)
    end

    def searches_repository
      @searches_repository ||= Searches::SearchesRepository.new
    end

    def params
      @params
    end

    def page
      @page
    end

    def per_page
      @per_page
    end

  end
end