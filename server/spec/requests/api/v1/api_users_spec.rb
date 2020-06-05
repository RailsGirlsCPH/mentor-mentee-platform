RSpec.describe Api::V1::ApiUsersController, type: :request do


  # initialize test data
  let!(:api_user_list){create_list(:api_user, 2)}
  let!(:api_user_id) {api_user_list.first.id}
  let!(:authorization){token_generator(api_user_id)}

  describe 'ApiUsers API', capture_examples: true do
    path '/api/v1/signup/' do
      post 'Create a new user' do
        tags 'redirects to api#create, allows creation of user'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string 
        parameter name: :api_user, in: :body,schema: {
                    type: :object,
                    properties: {
                      email: {type: :string},
                      password: {type: :string},
                      password_confirmation: {type: :string},
                      username: {type: :string},
                      mentor: {type: :boolean},
                      mentee: {type: :boolean},
                      first_name: {type: :string},
                      last_name: {type: :string},
                      city: {type: :string}
                    },
                    required: ['email', 'password_digest', 'username', 'mentor', 'mentee']
                  }
        response '200', 'user created' do
          let(:api_user) {{email: 'Test_email@email.com', password: 'pwd1',password_confirmation: 'pwd1', username: 'user1', mentor: false, mentee: true}}
          run_test! do
            expect(json['message']).to match(/Account created successfully/)
            expect(json['auth_token']).not_to be_nil
            expect([json["email"], json["username"]]).to eq(["Test_email@email.com", "user1"])
          end
        end


        response '422', 'user created' do
          let!(:api_user) {nil}
          run_test! do
            expect(json['message']).to match(/Validation failed: Password can't be blank, Email can't be blank, Password digest can't be blank, Username can't be blank, Api user must either want to be a mentor or mentee or both/)
            expect(json['auth_token']).to be_nil
          end
        end


        context 'Check requirement for unique email, pwd and username' do
          let(:non_unique) do 
            {email: 'Test_email@email.com', password: 'pwd1', password_confirmation: 'pwd1', username: 'user1', mentor: false, mentee: true}
          end
          before {post "/api/v1/signup/", params: non_unique, as: :json}
          before {post "/api/v1/signup/", params: non_unique, as: :json}
          it 'returns error regarding non unique params' do
            expect(json['message']).to match(/Validation failed: Email has already been taken, Username has already been taken/)
          end
        end


      end
    end

    path '/api/v1/api_users/' do

      get 'Displays all Users' do
        tags 'List all Users'
        parameter name: :authorization, :in => :header, :type => :string 

        response '200', 'list users' do
          run_test! do
            expect(json.size).to eq(2)
          end
        end
      end
    end

    path '/api/v1/api_users/{id}' do

      get 'Retrieves a user' do
        tags 'Return a User'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string 
        parameter name: :id, :in => :path, :type => :string

        response '200', 'user found' do
          schema type: :object,
                 properties: {
                   email: {type: :string},
                   username: {type: :string},
                   mentor: {type: :boolean},
                   mentee: {type: :boolean},
                 },
                 required: ['email', 'username', 'mentor', 'mentee']

          let(:id) {ApiUser.create(email: 'Test_email@email.com', password: 'pwd1', password_confirmation: 'pwd1', username: 'user1', mentor: false, mentee: true).id}
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

    # http://localhost:3000/api/v1/api_users/36/wishes

  end
end


