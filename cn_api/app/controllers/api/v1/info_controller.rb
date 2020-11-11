module Api
  module V1
    class InfoController < ApplicationController

      # GET /info
      def index
        response = respond_to_request(Info.get_info)
        render json: response[:json], status: response[:status]
      end

    end
  end
end
