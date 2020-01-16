module RickyAndMorty
  class EpisodeParser
    def parse(data)
      { air_date: data[:air_date] }
    end
  end
end