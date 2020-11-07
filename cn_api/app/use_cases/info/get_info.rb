require 'caze'

module Info
  class GetInfo
    include Caze

    attr_reader :data_result
    export :call, as: :get_info

    def initialize()
      ;
    end

    def call
      data   = []
      meta   = {}
      errors = []
      begin
        data << server_data
      rescue => e
        errors << {error: e}
      end
      @data_result = DataResult.new(data: data, meta: meta, errors: errors)
    end

    private

    def server_name
      return 'Chuck Norris Joke Service'
    end

    def version
      return '0.0.1'
    end

    def total_categories
      Category.all.size
    end

    def total_searches
      Search.all.size
    end

    def total_jokes
      Joke.all.size
    end

    def server_data
      {
      "name":             server_name,
      "version":          version,
      "total_categories": total_categories,
      "total_searches":   total_searches,
      "total_jokes":      total_jokes
      }
    end
  end
end