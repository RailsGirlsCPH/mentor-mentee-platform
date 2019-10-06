require 'rails_helper'

RSpec.describe Api::V1::ApiUsersController, type: :request do
#RSpec.describe 'api_users API', type: :request do

  # initialize test data
  let!(:api_users){create_list(:api_user, 10)}
  let(:api_user_id) {api_users.first.id}

  # Test suite for GET  /api/v1/api_users
  describe 'GET /api/v1/api_users' do
    before {get "/api/v1/api_users"}

    it 'returns api_users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/api_userss/:id
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
      # send json payload
      { 'email': 'Test_email@email.com', 'password_digest': 'password1'}.to_json

      context 'when request is valid' do
        before { post "/api/v1/api_users",  params: valid_attributes}

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'returns same params as entered' do
          expect(json['email'], json['password_digest']).to eq('Test_email@email.com','password1')
        end
      end
    end

    context 'when the request is invalid as no params' do
      let(:invalid_attributes) { { api_user: { email: nil } }.to_json }
      before { post "/api/v1/api_users", params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/param is missing or the value is empty: api_user/)
      end
    end

    context 'when the request is invalid as only some requird params' do
      let(:invalid_attributes) { { 'api_user': { 'email': 'email@email.com' } }.to_json }
      before { post "/api/v1/api_users", params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/param is missing or the value is empty: api_user/)
      end
    end

  end

  # Test suite for Patch /api/v1/api_userss/:id
  describe 'PATCH /api/v1/api_users/:id' do
        let(:valid_attributes) do
          # send json payload
          { 'first_name': 'Bobby','last_name': 'Dylan', 'city': 'Mexico', 'email': 'Test_email@email.com', 'password_digest': 'password1', 'mentor': True, 'mentee': False}.to_json
          let(:api_user_id) {api_users.first.id}

          context 'when request is valid' do
            before { patch "/api/v1/api_users/#{api_user_id}/",  params: valid_attributes}
   
            it 'returns status code 204' do
              expect(response).to have_http_status(204)
            end
          end

          context 'check that parameters have updated correctly' do
            before { get "/api/v1/api_users/#{api_user_id}/",  params: valid_attributes}
          end

          it 'returns same params as entered' do
            expect(json['first_name'],json['last_name'],json['city'], json['email'], json['password_digest'],json['mentor'],json['mentee']).to eq('Bobby', 'Dylan','Mexico', 'Test_email@email.com','password1', True, False)
          end

        end

        context 'when api_user does not exist' do
          let(:api_user_id) {0}
          let(:valid_attributes) do
            # send json payload
            { 'email': 'Test_email@email.com', 'password_digest': 'password1'}.to_json
            before { patch "/api/v1/api_users/#{api_user_id}/", params: valid_attributes}

            it 'returns status code 404' do
              expect(response).to have_http_status(404)
            end

            it 'returns message informing no user with that id' do
              expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
            end
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
