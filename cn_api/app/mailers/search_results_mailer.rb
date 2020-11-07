class SearchResultsMailer < ApplicationMailer
  default :from => 'irimi1977@gmail.com'

  def send_search_results_email(search)
    @search = search
    mail(to:      @search.email,
         subject: "Your results for search type '#{@search.search_type}'" )
  end
end