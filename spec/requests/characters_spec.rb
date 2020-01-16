require 'rails_helper'

RSpec.describe 'Characters API', type: :request do
  include RickyAndMortyMock
  include Json
  
  describe 'GET /characters/:id' do
    it 'should return 200 ok with valid id' do
      stub_get_char = mock_get_character(id: 2)
      stub_get_ep = mock_get_episode(id: 1)

      get '/api/v1/characters/2'

      expect(response).to have_http_status(200)

      remove_request_stub(stub_get_char)
      remove_request_stub(stub_get_ep)
    end

    it 'should return air date for valid character' do
      stub_get_char = mock_get_character(id: 2)
      stub_get_ep = mock_get_episode(id: 1)

      get '/api/v1/characters/2'
      
      expect(response.body).to eq('December 2, 2013')

      remove_request_stub(stub_get_char)
      remove_request_stub(stub_get_ep)
    end

    it 'should return 422 when id is not numeric' do
      get '/api/v1/characters/pickle'

      expect(response).to have_http_status(422)
    end

    it 'should return 404 when id is not found' do
      stub_get_char = mock_get_character(id: 9652, success: false)
      stub_get_ep = mock_get_episode(id: 3, success: false)

      get '/api/v1/characters/9652'
      
      expect(response).to have_http_status(404)

      remove_request_stub(stub_get_char)
      remove_request_stub(stub_get_ep)
    end

    it 'should return status error and message with unknown character' do
      stub_get_char = mock_get_character(id: 9125, success: false)
      stub_get_ep = mock_get_episode(id: 3, success: false)

      get '/api/v1/characters/9125'
      
      result = convert_to_json(response.body)

      expect(result['status']).to eq('error')
      expect(result['message']).to eq('404 Not Found')

      remove_request_stub(stub_get_char)
      remove_request_stub(stub_get_ep)
    end
  end
end