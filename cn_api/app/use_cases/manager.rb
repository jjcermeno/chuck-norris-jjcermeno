require 'caze'

module Manager
  include Caze

  has_use_case :fetch_categories, Categories::FetchCategories
end