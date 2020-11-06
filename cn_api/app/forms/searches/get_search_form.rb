module Searches
  class GetSearchForm

    include ActiveModel::Model

    attr_accessor :id

    def self.from_json(data)
      new_dto = new
      new_dto.id = data[:id] if data[:id]
      new_dto
    end

    validates_presence_of :id

  end
end
