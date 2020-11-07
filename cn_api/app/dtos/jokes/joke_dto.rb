module Jokes
  class JokeDto

    include ActiveModel::Model

    attr_accessor :ext_id, :joke_value, :joke_url, :icon_url, :categories

    def self.from_json(data)
      new_dto = new
      new_dto.ext_id = data["id"].to_s if data["id"]
      new_dto.joke_value = data["value"] if data["value"]
      new_dto.joke_url = data["url"] if data["url"]
      new_dto.icon_url = data["icon_url"] if data["icon_url"]
      new_dto.categories = data["categories"] if data["categories"]
      new_dto
    end

  end
end
