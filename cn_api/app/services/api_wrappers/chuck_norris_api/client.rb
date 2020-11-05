# frozen_string_literal: true
module ApiWrappers
  module ChuckNorrisApi
    class Client
      include HttpStatusCodes
      include ApiExceptions

      API_ENDPOINT = ENV['API_ENDPOINT'] || 'https://api.chucknorris.io/'

      def initialize; end

      def get_categories
        request(
        http_method: :get,
        endpoint:    "jokes/categories"
        )
      end

      def joke_random
        request(
        http_method: :get,
        endpoint:    "jokes/random"
        )
      end

      def jokes_by_category(category)
        request(
        http_method: :get,
        endpoint:    "jokes/random?category=#{category}"
        )
      end

      def jokes_by_search_word(word)
        request(
        http_method: :get,
        endpoint:    "jokes/search?query=#{word}"
        )
      end

      private

      def request(http_method:, endpoint:, params: {})
        response        = client.public_send(http_method, endpoint, params)
        @response       = response
        parsed_response = JSON.parse(response.body)
        return parsed_response if response_successful?

        raise error_class, "Code: #{response.status}, response: #{response.body}"
      end

      def error_class
        case @response.status
        when HTTP_BAD_REQUEST_CODE
          BadRequestError
        when HTTP_UNAUTHORIZED_CODE
          UnauthorizedError
        when HTTP_FORBIDDEN_CODE
          ForbiddenError
        when HTTP_NOT_FOUND_CODE
          NotFoundError
        when HTTP_UNPROCESSABLE_ENTITY_CODE
          UnprocessableEntityError
        else
          ApiError
        end
      end

      def response_successful?
        @response.status == HTTP_OK_CODE
      end

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
        end
      end

    end
  end
end

