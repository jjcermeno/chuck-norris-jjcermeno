module Api
  module V1
    class InfoController < ApplicationController

      # GET /info
      def index
        data_result = Info.get_info
        status = data_result.errors.present? ? :unprocessable_entity : :ok
        json = Oj.dump(data_result.as_json)
        render json: json, status: status
      end

    end
  end
end
