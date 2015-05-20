require 'rails_helper'

describe 'Provile API' do
  describe 'GET /me' do
    context 'unauthorize' do
      it 'returns 401 status if there is not access_token' do
        get '/api/v1/profiles/me', format: :json
        expect(responce.status).to eq 401
      end

      it 'returns 401 status if there is not access_token' do
        get '/api/v1/profiles/me', format: :json, access_token: '1234'
        expect(responce.status).to eq 401
      end
    end
  end
end
