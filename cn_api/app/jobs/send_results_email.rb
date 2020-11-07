class SendResultsEmail < ApplicationJob
  queue_as :default

  def perform(search)
    SearchResultsMailer.send_search_results_email(search).deliver
  end

end

