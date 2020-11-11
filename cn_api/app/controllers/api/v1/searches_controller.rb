module Api
  module V1
    class SearchesController < ApplicationController

      # GET /api/v1/searches
      def index
        response = respond_to_request(Manager.list_searches(params))
        render json: response[:json], status: response[:status]
      end

      # GET /api/v1/searches/:id
      def show
        response = respond_to_request(Manager.get_search(params), [:ok, :not_found], "data")
        render json: response[:json], status: response[:status]
      end

      # POST /api/v1/searches
      def create
        response = respond_to_request(Manager.create_search(params), [:created, :unprocessable_entity], "data")
        render json: response[:json], status: response[:status]
      end
    end
  end
end
