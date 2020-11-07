module Jokes
  class JokesRepository

    def joke_exists?(id)
      Joke.where(id: id).first.present?
    end

    def joke_exists_by_ext_id?(ext_id)
      Joke.where(ext_id: id).first.present?
    end

    def get_joke(id)
      Joke.where(id: id).first
    end

    def get_joke_by_ext_id(ext_id)
      Joke.where(ext_id: ext_id).first
    end

    def find_or_create(dto)
      joke = get_joke_by_ext_id(dto.ext_id)
      unless joke.present?
        joke            = Joke.new
        joke.ext_id     = dto.ext_id
        joke.joke_value = dto.joke_value
        joke.joke_url   = dto.joke_url
        joke.icon_url   = dto.icon_url
      end
      joke
    end

    def show_joke(id)
      Api::V1::JokePresenter.new(get_joke(id))
    end

    def show_joke_ext_id(ext_id)
      Api::V1::JokePresenter.new(get_joke_by_ext_id(ext_id))
    end

  end
end