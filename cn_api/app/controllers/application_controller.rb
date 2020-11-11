class ApplicationController < ActionController::API
  include ErrorHandler

  private
  def respond_to_request(use_case)
    data_result = use_case
    status = data_result.errors.present? ? :unprocessable_entity : :ok
    json = Oj.dump(data_result.as_json)
    {json: json, status: status}
  end
end
