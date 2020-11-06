module Searches
  class SearchesRepository

    def search_exists?(id)
      Search.where(id: id).first.present?
    end

    def get_search(id)
      get_searches(id).first
    end

    def get_searches(id)
      Search.where(id: id)
    end

    def create_search(params) end

    def show_search(id)
      Api::V1::SearchPresenter.new(get_search(id))
    end

    def get_searches_page(page, per_page)
      Search.paginate(page: page, per_page: per_page)
    end

    def show_searches(searches)
      CollectionPresenter.new(
      searches,
      Api::V1::SearchPresenter
      )
    end

    def total_searches
      Search.all.size
    end

  end
end