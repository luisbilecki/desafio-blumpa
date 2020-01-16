module RickyAndMorty
  class Fetcher < Base
    def fetch_single_character(id)
      call("/api/character/#{id}", CharacterParser.new)
    end

    def fetch_episode(id)
      call("/api/episode/#{id}", EpisodeParser.new)
    end
  end
end