module Api
  module V1
    class CategoriesController < ApplicationController

      # GET /categories
      def index
        data_result = Manager.fetch_categories
        status = data_result.errors.present? ? :unprocessable_entity : :ok
        json = Oj.dump(data_result.as_json)
        render json: json, status: status
      end

    end
  end
end
