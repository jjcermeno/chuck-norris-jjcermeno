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
        data_result = Manager.get_search(params)
        status = data_result.data.present? ? :ok : :not_found
        json = Oj.dump(data_result.as_json)
        render json: json, status: status
      end

      # POST /api/v1/searches
      def create
        data_result = Manager.create_search(params)
        status = data_result.data.present? ? :created : :unprocessable_entity
        json = Oj.dump(data_result.as_json)
        render json: json, status: status
      end
    end
  end
end
