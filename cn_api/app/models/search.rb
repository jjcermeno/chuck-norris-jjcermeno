class Search < ApplicationRecord
  has_many :joke_searches
  has_many :jokes, :through => :joke_searches

  validates_presence_of :search_type
end
