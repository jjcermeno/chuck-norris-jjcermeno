# frozen_string_literal: true

module Api
  module V1
    class CategoryPresenter < BasePresenter
      def as_json
        {
        "id":           @resource.id,
        "categoryName": @resource.category_name,
        "createdAt":    datetime_to_string(@resource.created_at),
        "updatedAt":    datetime_to_string(@resource.updated_at)
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
