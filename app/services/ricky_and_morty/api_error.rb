module RickyAndMorty
  class ApiError < StandardError
    attr_reader :status

    def initialize(status)
      @status = status
    end

    def message
      @status.to_s
    end
  end
end