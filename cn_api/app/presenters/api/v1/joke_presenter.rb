# frozen_string_literal: true

module Api
  module V1
    class JokePresenter < BasePresenter
      def as_json
        {
        "id":        @resource.id,
        "jokeValue": @resource.search_type,
        "jokeUrl":   @resource.search_value,
        "iconUrl":   @resource.email,
        "createdAt": datetime_to_string(@resource.created_at),
        "updatedAt": datetime_to_string(@resource.updated_at),
        "extId":     @resource.ext_id
        }.as_json
      end

      private

      def date_to_unix(date)
        return unless date
        date.to_time.to_i
      end

      def datetime_to_string(datetime)
        return unless datetime
        datetime.to_s
      end

    end
  end
end
