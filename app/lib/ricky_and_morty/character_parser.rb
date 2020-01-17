module RickyAndMorty
  class CharacterParser
    def parse(data)
      episodes = data[:episode]
      episode_url = URI.parse(episodes[0])

      # Return only needed data for character (first episode number)
      # path -> /api/episode/1 ->
      { first_episode: episode_url.path.split('/')[3] }
    end
  end
end