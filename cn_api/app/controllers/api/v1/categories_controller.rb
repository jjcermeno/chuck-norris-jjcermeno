module Api
  module V1
    class CategoriesController < ApplicationController

      # GET /api/v1/categories
      def index
        response = respond_to_request(Manager.fetch_categories)
        render json: response[:json], status: response[:status]
      end

    end
  end
end
