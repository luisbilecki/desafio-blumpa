module RickyAndMorty
  class Base
    API_URL = 'https://rickandmortyapi.com'

    def call(path, parser)
      response = HTTP.get("#{API_URL}/#{path}")
      status = response.status

      raise error_message(status) unless status.success?

      data = json_to_hash(response.to_s)

      parser.parse(data)
    end

    private 

    def json_to_hash(response)
      JSON.parse(response).deep_symbolize_keys
    end

    def error_message(status)
      status.to_s
    end
  end
end