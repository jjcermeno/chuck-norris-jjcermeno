class Joke < ApplicationRecord
  has_many :joke_categories
  has_many :joke_searches
  has_many :categories, :through => :joke_categories
  has_many :searches, :through => :joke_searches
end