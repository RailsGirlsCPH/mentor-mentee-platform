# # Decided not to use mocking, but this could be changed in the future. Mocking could allow test to be independent of functionality of authorisation behaviour.
# # example
# allow(feed).to receive(:fetch).and_return("imagine I'm a JSON string")
# feed.fetch
# => "imagine I'm a JSON string"
# example for authorisation
#          allow(AuthorizeApiRequest).to receive_message_chain(:new, :call).and_return(current_user)}

RSpec.describe Api::V1::ProfilesController, type: :request do
  let!(:user_list) {create_list(:api_user, 5)}
  let!(:current_user) {user_list.first}
  let(:authorization){token_generator(current_user.id)}

  describe 'Profiles Api', capture_examples: true do
    path '/api/v1/profile/' do

      get 'Display user you are logged in as' do
        tags 'Display user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string 

        response '422', 'no token' do
          let(:authorization){nil}
          run_test! do
            expect(json["message"]).to eq("Missing token")
          end
        end

        response '200', 'Display current user logged in' do
          run_test! do
            expect(json["id"]).to eq(current_user.id)
          end
        end

      end

      delete  'You can only delete a user that you are logged in as' do
        tags 'Delete user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string

        response '422', 'no token' do
          let(:authorization){nil}
          run_test! do
            expect(json["message"]).to eq("Missing token")
          end
        end

        response '200', 'Delete user currently logged in' do
          run_test! do
            expect(json["message"]).to eq("Account deleted sucessfully")
          end
        end

        context 'Check that user no longer exists after delete' do
          before do
            delete "/api/v1/profile/", headers: {Authorization: "Bearer: #{authorization}"}
            get "/api/v1/api_users/#{current_user.id}/", headers: {Authorization: "Bearer: #{authorization}"}
          end
          it 'returns error saying user cannot be found' do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{current_user.id}/)
          end
        end

      end


      patch 'You can only update the user you are logged in as' do
        tags 'Update the user you are logged in as'
        # description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
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

        response '200', 'User updated' do
          let(:api_user) { { email: 'Test_email2@email.com', first_name: 'Bob', last_name: 'Brown' } }
          run_test! do
            expect([json["email"], json["first_name"], json["last_name"]]).to match(["Test_email2@email.com","Bob","Brown"])
          end
        end

        response '422', 'no token' do
          let(:authorization){nil}
          let(:api_user) { { email: 'Test_email2@email.com', first_name: 'Bob', last_name: 'Brown' } }
          run_test! do
            expect(json["message"]).to eq("Missing token")
          end
        end


        response '422', 'no token' do
          before {ApiUser.create(email: 'Test_email3@email.com', password_digest: 'pwd1', username: 'user1', mentor: false, mentee: true)}
          let(:api_user) { { email: 'Test_email3@email.com', first_name: 'Bob', last_name: 'Brown' } }
          run_test! do
            expect(json["message"]).to eq("Validation failed: Email has already been taken")
          end
        end
      end
    end
  end
end
