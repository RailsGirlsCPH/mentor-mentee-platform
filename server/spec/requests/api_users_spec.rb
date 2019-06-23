require 'rails_helper'

RSpec.describe 'api_users API', type: :request do

  # initialize test data
  let!(:api_users){create_list(:api_user, 10)}
  let(:api_user_id) {api_users.first.id}

  #Test suite for GET /api_users
  describe 'GET /api_users' do
    # make HTTP GET request before each example
    before {get '/api_users'}

    it 'returns api_users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api_user/:id
  # describe 'GET /api_users/:id' do
  #   before {get "/api_users/#{api_user_id}"}

  #   context 'when the record exists' do
  #     it 'returns the api_user' do
  #       expect(json).not_to_be_empty
  #       expect(json['id']).to eq(api_user_id)
  #     end

  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #   end
  # end

end
