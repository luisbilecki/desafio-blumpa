module RickyAndMorty
  class Base      
    API_URL = 'https://rickandmortyapi.com'

    def call(path, parser)
      response = HTTP.get("#{API_URL}/#{path}")
      status = response.status

      raise RickyAndMorty::ApiError, status unless status.success?

      data = json_to_hash(response.to_s)

      parser.parse(data)
    end

    private 

    def json_to_hash(response)
      JSON.parse(response).deep_symbolize_keys
    end
  end
end