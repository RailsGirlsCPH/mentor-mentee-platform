require 'swagger_helper'
require 'rails_helper'
RSpec.describe Api::V1::ApiUsersController, type: :request do


  # initialize test data
  let!(:api_users){create_list(:api_user, 2)}
  let!(:api_user_id) {api_users.first.id}

  describe 'ApiUsers API', capture_examples: true do
    path '/api/v1/api_users/' do

      get 'Displays all Users' do
        tags 'List all Users'

        response '200', 'list users' do
          run_test! do
            expect(json.size).to eq(2)
          end
        end
      end

      post 'Create a user' do
        tags 'Create an API User'
        consumes 'application/json'
        parameter name: :api_user, in: :body,schema: {
                    type: :object,
                    properties: {
                      email: {type: :string},
                      password_digest: {type: :string},
                      username: {type: :string},
                      mentor: {type: :boolean},
                      mentee: {type: :boolean},
                      first_name: {type: :string},
                      last_name: {type: :string},
                      city: {type: :string}
                    },
                    required: ['email', 'password_digest', 'username', 'mentor', 'mentee']
                  }

        response '201', 'user created' do
          let(:api_user) {{email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true}}
          run_test! do
            expect([json["email"], json["password_digest"], json["username"]]).to eq(["Test_email@email.com",  "pwd1",  "user1"])
          end
        end

        response '422', 'invalid request' do
          let(:api_user) {{}}
          run_test! do
            expect(json['message']).to match(/param is missing or the value is empty: api_user/)
          end
        end

        response '422', 'required field, eg. password, can not be blank' do
          let(:api_user) {{email: 'Test_email@email.com', username: 'user1', mentor: false, mentee: true}}
          run_test! do
            expect(json['message']).to match(/Validation failed: Password digest can't be blank/)
          end
        end

        context 'Check requirement for unique email, pwd and username' do
          let(:non_unique) do 
            {email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true}
          end
          before {post "/api/v1/api_users/", params: non_unique, as: :json}
          before {post "/api/v1/api_users/", params: non_unique, as: :json}
          it 'returns error regarding non unique params' do
            expect(json['message']).to match(/Validation failed: Email has already been taken, Username has already been taken/)
          end
        end
      end
    end

    path '/api/v1/api_users/{id}' do

      get 'Retrieves a user' do
        tags 'Return a User'
        consumes 'application/json'
        parameter name: :id, :in => :path, :type => :string

        response '200', 'user found' do
          schema type: :object,
                 properties: {
                   email: {type: :string},
                   password_digest: {type: :string},
                   username: {type: :string},
                   mentor: {type: :boolean},
                   mentee: {type: :boolean},
                 },
                 required: ['email', 'password_digest', 'username', 'mentor', 'mentee']

          let(:id) {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          run_test!
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{id}/)
          end
        end
      end


      delete 'Deletes a user' do
        tags 'Delete User'
        consumes 'application/json'
        parameter name: :id,  :in => :path, :type => :string

        response '204', 'meeting interval deleted' do
          let(:id) {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          run_test!
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{id}/)
          end
      end
      end
    end
  end
end



#   # Test suite for Patch /api/v1/api_userss/:id
#   describe 'PATCH /api/v1/api_users/:id' do
#     let!(:api_user_id) {api_users.first.id}
#     let(:valid_attributes) do
#       { first_name: 'Bobby',last_name: 'Dylan', city: 'Mexico', email: 'Test_email13@email.com', username: 'user13', password_digest: 'password1' }
#     end
   

#     before { patch "/api/v1/api_users/#{api_user_id}/",  params: valid_attributes, as: :json}
#     it 'returns status code 204' do
#       expect(response).to have_http_status(204)
#     end
    
#     context 'check update worked' do
#       before { get "/api/v1/api_users/#{api_user_id}/"}
#       it 'returns same params as entered' do
        
#         expect([json["first_name"], json["last_name"], json["city"], json["email"], json["password_digest"], json["username"]]).to eq(['Bobby', 'Dylan','Mexico', 'Test_email13@email.com','password1','user13'])
#       end
#     end


#     context 'invalid email' do
#       before { patch "/api/v1/api_users/#{api_user_id}/", params: {email: api_users.second.email} , as: :json}

#       it 'returns status code 422' do
#         expect(response).to have_http_status(422)
#       end

#       it 'returns message informing no user with that id' do
#         expect(json["message"]).to match(/Validation failed: Email has already been taken/)
#       end
#     end

#     context 'when username already in use' do
#       before { patch "/api/v1/api_users/#{api_user_id}/", params: {username: api_users.second.username}, as: :json}

#       it 'returns status code 422' do
#         expect(response).to have_http_status(422)
#       end

#       it 'returns message informing no user with that id' do
#         expect(json["message"]).to match(/Validation failed: Username has already been taken/)
#       end
#     end

#     context 'when api_user does not exist' do
#       let(:api_user_id) {0}
#       before { patch "/api/v1/api_users/#{api_user_id}/", params: valid_attributes, as: :json}
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end

#       it 'returns message informing no user with that id' do
#         expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
#       end
#     end
#   end


