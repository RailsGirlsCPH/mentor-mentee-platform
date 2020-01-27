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

        context 'Check that user no longer exists after delete' do
          let(:id) {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          before {delete "/api/v1/api_users/#{id}/", params: id, as: :json}
          before {get "/api/v1/api_users/#{id}/", params: id, as: :json}
          it 'returns error saying user cannot be found' do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{id}/)
          end
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{id}/)
          end
        end
      end

      patch 'Update an API User' do
        tags 'Update an APi User'
        description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :id,  :in => :path, :type => :string
        parameter name: :api_user, in: :body, schema: {
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
          required: [ ]
        }

        response '204', 'user updated' do
          let(:id) {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          let(:api_user) { { email: 'Test_email2@email.com', first_name: 'Bob' } }
          run_test!
        end

        context 'Check that correct updates are made' do
          let(:id) {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          let(:updateparams) {{email: 'Test_email2@email.com', first_name: 'Bob'}}
          before {patch "/api/v1/api_users/#{id}/", params: updateparams, as: :json}
          before {get "/api/v1/api_users/#{id}/"}
          it 'returns same params as updated' do
            expect([json["email"], json["first_name"]]).to eq(["Test_email2@email.com",  "Bob"])
          end
        end


        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:api_user) { { email: 'Test_email2@email.com', first_name: 'Bob' } }
          run_test! do 
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{id}/)
          end
        end


        response '422', 'proposed username not valid' do
          before {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          let(:id) {ApiUser.first.id}
          let(:api_user) { { email: 'Test_email@email.com' } }
          run_test! do
            expect(json["message"]).to match(/Validation failed: Email has already been taken/)
          end
        end


        response '422', 'parameter not unqiue valid' do
          before {ApiUser.create(email: 'Test_email@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
          let(:id) {ApiUser.first.id}
          let(:api_user) { { username: 'user1'} }
          run_test! do
            expect(json["message"]).to match(/Validation failed: Username has already been taken/)
          end
        end
      end

    end
  end
end



