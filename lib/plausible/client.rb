module Plausible
  class Client
    class Error < StandardError
    end

    def initialize
      @connection = Faraday.new(
        url: "https://plausible.io",
        headers: {"Authorization" => "Bearer #{ENV["PLAUSIBLE_API_KEY"]}"}
      ) do |f|
        f.request :json
        f.response :json
      end
    end

    def timeseries(site_id)
      connection.get("/api/v1/stats/timeseries", {site_id: site_id})
    end

    def breakdown(site_id, options = {})
      params = {site_id: site_id, property: "event:page", limit: 20}.merge(options)
      connection.get("/api/v1/stats/breakdown", params)
    end

    private

    attr_reader :connection
  end
end
