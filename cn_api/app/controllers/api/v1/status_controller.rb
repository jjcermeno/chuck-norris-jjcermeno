module Api
  module V1
    class StatusController < ApplicationController

      # GET /status
      def index
        data_result = Status.get_status
        status = data_result.errors.present? ? :unprocessable_entity : :ok
        json = Oj.dump(data_result.as_json)
        render json: json, status: status
      end

    end
  end
end
