module Jokes
  class JokeForm < JokeDto

    validates_presence_of :ext_id
    validates_presence_of :joke_value
    validates_presence_of :joke_url

  end
end
