module Searches
  class CreateSearchForm

    include ActiveModel::Model

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

    attr_accessor :search_type, :search_value, :email,
    :searchType, :searchValue

    def self.from_json(data)
      new_dto = new
      new_dto.search_type = data[:searchType].to_s.downcase if data[:searchType]
      new_dto.search_value = data[:searchValue] if data[:searchValue]
      new_dto.searchType = new_dto.search_type
      new_dto.searchValue = new_dto.search_value
      new_dto.email = data[:email] if data[:email]
      new_dto
    end

    validates_presence_of :searchType
    # validates_presence_of :search_value
    validate :search_type_allowed
    validate :search_value_allowed
    validate :email_format

    def search_type_allowed
      errors.add :searchType ,"only 'word', 'category' or 'random' are allowed" unless %w(word category random).include?(search_type.to_s.downcase)
    end

    def search_value_allowed
      if search_type.present? && %w(word category).include?(search_type.to_s.downcase)
        errors.add :searchValue ,"can't be blank when using 'word' or 'category' as search type" unless search_value.present?
      end
    end

    def email_format
      if email.present?
        errors.add :email, 'invalid' unless email =~ VALID_EMAIL_REGEX
      end
    end

  end
end
