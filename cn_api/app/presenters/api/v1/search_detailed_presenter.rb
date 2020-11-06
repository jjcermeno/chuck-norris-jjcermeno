# frozen_string_literal: true

module Api
  module V1
    class SearchDetailedPresenter < BasePresenter
      def as_json
        {
        "id":          @resource.id,
        "searchType":  @resource.search_type,
        "searchValue": @resource.search_value,
        "email":       @resource.email,
        "createdAt":   datetime_to_string(@resource.created_at),
        "updatedAt":   datetime_to_string(@resource.updated_at),
        "total_jokes": jokes_count,
        "jokes":       jokes
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

      def jokes_count
        @resource.jokes.size
      end

      def jokes
        CollectionPresenter.new(
        @resource.jokes,
        Api::V1::JokePresenter
        )
      end

    end
  end
end
