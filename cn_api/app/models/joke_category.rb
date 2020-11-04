class JokeCategory < ApplicationRecord
  belongs_to :joke
  belongs_to :category
end
