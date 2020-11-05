require 'caze'

module Categories
  class FetchCategories
    include Caze

    attr_reader :data_result
    export :call, as: :fetch_categories

    def initialize
      @data   = []
      @meta   = {}
      @errors = []
    end

    def call
      begin
        compare_current_categories
      rescue => e
        @errors << {error: e}
      end
      list_categories
      @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

    def compare_current_categories
      remote_categories = get_remote_categories
      current_categories = get_current_categories
      diff_categories = remote_categories - current_categories
      if diff_categories.size > 0
        categories_repository.add_new_categories(diff_categories)
      end
    end

    def get_remote_categories
      cn_api     = ApiWrappers::ChuckNorrisApi::Client.new
      cn_api.get_categories
      # category   = cn_api.jokes_by_category("animal")
      # random     = cn_api.joke_random
      # jokes      = cn_api.jokes_by_search_word('hola')
    end

    def get_current_categories
      categories_repository.get_current_categories_by_name
    end

    def categories_repository
      @categories_repository ||= Categories::CategoriesRepository.new
    end

    def list_categories
      @data = categories_repository.get_all_categories
      @meta["total_count"] = @data.as_json.size.to_i
    end

  end
end