require 'rails_helper'

RSpec.describe 'Characters API', type: :request do
  let(:headers){ { 'accept' => 'application/json' } }

  describe 'GET /characters/:id' do
    it 'should return 200 ok with valid id' do
      get '/api/v1/characters/1'
      
      expect(response).to have_http_status(200)
    end

    it 'should return air date for valid character' do
      get '/api/v1/characters/1'
      
      expect(response.body).to eq('December 2, 2013')
    end

    it 'should return 422 when id is not numeric' do
      get '/api/v1/characters/pickle'

      expect(response).to have_http_status(422)
    end
  end
end