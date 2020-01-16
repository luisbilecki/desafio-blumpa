module RickyAndMortyMock
  BASE_URL = 'https://rickandmortyapi.com'

  def mock_get_character(id:, success: true)
    content = read_json('./spec/support/ricky_and_morty_api/character_response.json')
    stub = stub_request(:get, "#{BASE_URL}/api/character/#{id}")
    
    if success
      stub.to_return(status: 200, body: content)
    else
      stub.to_return(status: [404, 'Not Found'])
    end
  end

  def mock_get_episode(id:, success: true)
    content = read_json('./spec/support/ricky_and_morty_api/episode_response.json')
    stub = stub_request(:get, "#{BASE_URL}/api/episode/#{id}")

    if success
      stub.to_return(status: 200, body: content)
    else
      stub.to_return(status: [404, 'Not Found'])
    end
  end
  
  private

  def read_json(file)
    IO.read(file)
  end
end