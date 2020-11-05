module Api
  module V1
    class CategoriesController < ApplicationController

      # GET /categories
      def index
        data = {}
        json = Oj.dump(data)
        render json: json, status: :ok
      end

    end
  end
end
