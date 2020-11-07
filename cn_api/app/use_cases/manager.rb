module Manager
  include Caze

  has_use_case :fetch_categories, Categories::FetchCategories
  has_use_case :list_searches, Searches::ListSearches
  has_use_case :get_search, Searches::GetSearch
  has_use_case :create_search, Searches::CreateSearch
end