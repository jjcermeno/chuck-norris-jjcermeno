module Searches
  class CreateSearchDto

    include ActiveModel::Model

    attr_accessor :search_type, :search_value, :email,
                  :searchType, :searchValue

    def self.from_json(data)
      new_dto              = new
      new_dto.search_type  = data[:searchType].to_s.downcase if data[:searchType]
      new_dto.search_value = data[:searchValue] if data[:searchValue]
      new_dto.searchType   = new_dto.search_type
      new_dto.searchValue  = new_dto.search_value
      new_dto.email        = data[:email] if data[:email]
      new_dto
    end
  end
end
