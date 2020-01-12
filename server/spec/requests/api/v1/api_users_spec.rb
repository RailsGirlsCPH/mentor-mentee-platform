require 'rails_helper'


RSpec.describe Api::V1::ApiUsersController, type: :request do


  # initialize test data
  let!(:api_users){create_list(:api_user, 2)}
  let!(:api_user_id) {api_users.first.id}


  # Test suite for GET  /api/v1/api_users
  describe 'GET /api/v1/api_users' do
    before {get "/api/v1/api_users"}

    it 'returns api_users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/api_users/:id
  describe 'GET  /api/v1/api_users/:id' do
    before { get "/api/v1/api_users/#{api_user_id}/" }

    context 'when api_user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
         expect(json['id']).to eq(api_user_id)
      end
    end

    context 'when api_user does not exist' do
      let(:api_user_id) {0}
      before { get "/api/v1/api_users/#{api_user_id}/" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no user with that id' do
        expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
      end
    end
  end

  # Test suite POST /api/v1/api_user
  describe 'POST /api/v1/api_users' do
    let(:valid_attributes) do
      { email: 'Test_email@email.com', password_digest: 'password1', username: 'user11', mentor: true, mentee: true}
    end
    before { post '/api/v1/api_users',  params: valid_attributes, as: :json}
    context 'when request is valid' do  
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns same params as entered' do
        expect([json["email"], json["password_digest"], json["username"]]).to eq(["Test_email@email.com",  "password1",  "user11"])
      end
    end


    context 'when the request is invalid as no params' do
      invalid_attributes = { } 
      before { post '/api/v1/api_users', params: invalid_attributes, as: :json }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/param is missing or the value is empty: api_user/)
      end
    end

    context 'when the request is invalid as email already in use' do
      let(:invalid_email) do 
        { 'email': 'Test_email@email.com', 'password_digest': 'password2', 'username': 'user12', mentor: true, mentee: true }
      end
      before { post '/api/v1/api_users', params: invalid_email, as: :json }

      it 'returns status code 422' do
         expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Email has already been taken/)
      end
    end

    context 'when the request is invalid as username already in use' do
      let(:invalid_username) do 
        { 'email': 'Test_email_1@email.com', 'password_digest': 'password2', 'username': 'user11' , mentor: true, mentee: true}
      end
      before { post '/api/v1/api_users', params: invalid_username, as: :json }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Username has already been taken/)
      end
    end

    context 'when the request is invalid as only some requird params' do
      let(:some_invalid_attributes) {{ 'email': 'email@email.com' }} 
      before { post '/api/v1/api_users', params: some_invalid_attributes, as: :json }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password digest can't be blank, Username can't be blank, Mentor can't be blank, Mentee can't be blank/)
      end
    end
  end

  # Test suite for Patch /api/v1/api_userss/:id
  describe 'PATCH /api/v1/api_users/:id' do
    let!(:api_user_id) {api_users.first.id}
    let(:valid_attributes) do
      { first_name: 'Bobby',last_name: 'Dylan', city: 'Mexico', email: 'Test_email13@email.com', username: 'user13', password_digest: 'password1' }
    end
   

    before { patch "/api/v1/api_users/#{api_user_id}/",  params: valid_attributes, as: :json}
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
    
    context 'check update worked' do
      before { get "/api/v1/api_users/#{api_user_id}/"}
      it 'returns same params as entered' do
        
        expect([json["first_name"], json["last_name"], json["city"], json["email"], json["password_digest"], json["username"]]).to eq(['Bobby', 'Dylan','Mexico', 'Test_email13@email.com','password1','user13'])
      end
    end


    context 'invalid email' do
      before { patch "/api/v1/api_users/#{api_user_id}/", params: {email: api_users.second.email} , as: :json}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns message informing no user with that id' do
        expect(json["message"]).to match(/Validation failed: Email has already been taken/)
      end
    end

    context 'when username already in use' do
      before { patch "/api/v1/api_users/#{api_user_id}/", params: {username: api_users.second.username}, as: :json}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns message informing no user with that id' do
        expect(json["message"]).to match(/Validation failed: Username has already been taken/)
      end
    end

    context 'when api_user does not exist' do
      let(:api_user_id) {0}
      before { patch "/api/v1/api_users/#{api_user_id}/", params: valid_attributes, as: :json}
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no user with that id' do
        expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
      end
    end
  end


  # Test suite for Delete /api/v1/api_userss/:id
  describe 'DELETE /api/v1/api_users/:id' do

    context 'when request made to delete a user' do
      let(:api_user_id) {api_users.first.id}
      before { delete "/api/v1/api_users/#{api_user_id}/" }
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when api_user does not exist' do
      let(:api_user_id) {0}
      before { delete "/api/v1/api_users/#{api_user_id}/" }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no user with that id' do
        expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
      end
    end
  end

end
