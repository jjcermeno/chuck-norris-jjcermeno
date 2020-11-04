class Joke < ApplicationRecord
  has_many :joke_categories
  has_many :joke_searches
  has_many :categories, :through => :joke_categories
  has_many :searches, :through => :joke_searches

  validates_presence_of :ext_id, :joke_value, :joke_url
  validates_uniqueness_of :ext_id
end