class Category < ApplicationRecord
  has_many :joke_categories
  has_many :jokes, through: :joke_categories

  # validates_presence_of :category_name
  validates_uniqueness_of :category_name
end
