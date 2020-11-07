module Searches
  class ResendEmail
    include Caze

    attr_reader :data_result
    export :call, as: :resend_email

    def initialize(params)
      @data   = []
      @meta   = {}
      @errors = []
      @params = params
      @id     = nil
    end

    def call
      begin
        check_params
        get_search
        send_email
      rescue => e
        @errors << {error: e}
        return DataResult.new(data: [], meta: @meta, errors: @errors)
      end
      @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

    def check_params
      form = Searches::GetSearchForm.from_json(@params)
      raise StandardError.new form.errors.messages unless form.valid?
      @id = form.id
    end

    def get_search
      @search = searches_repository.get_search(id)
      unless @search.present?
        raise StandardError.new "Search not found"
      end
    end

    def send_email
      if search.email.present?
        @data << searches_repository.show_simple_search(id)
        puts "-----------------DATA"
        puts @data.as_json
        puts "---------------------"
        SendResultsEmail.perform_later(search)
      else
        puts "--------------------- RAISED EXCEPTION NO EMAIL"
        raise StandardError.new "This Search has no email address to send to"
      end
    end

    def searches_repository
      @searches_repository ||= Searches::SearchesRepository.new
    end

    def id
      @id
    end

    def search
      @search
    end

  end
end