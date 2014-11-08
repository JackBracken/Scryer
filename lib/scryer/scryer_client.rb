require 'faraday'

module Scryer
  class Client
    def initialize(api_base="https://api.darklordpotter.net")
      @conn = Faraday.new(:url => api_base) do |faraday|
        faraday.request  :json             # form-encode POST params
        faraday.response :rashify                  # log requests to STDOUT
        faraday.response :json                  # log requests to STDOUT
        faraday.response :logger                  # log requests to STDOUT
        faraday.use :instrumentation
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def search(param_hash, from = 0, max = 25)
      newHash = {}
      param_hash.each do |k,v|
        newHash[k.to_s.camelize(:lower)] = v
      end


      puts newHash

      resp = @conn.post do |req|
        req.url '/v1/search', {:from => from, :max => max}
        req.body = newHash
      end

      resp.body
    end
  end


end
