require 'swagger_helper'
require 'rails_helper'
require 'pry'

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
  let(:Authorization){token_generator(current_user.id)}
  let(:valid_attributes) do
    attributes_for(:current_user, password_confirmation: current_user.password)
  end
  
  describe 'Profiles Api', capture_examples: true do
    path '/api/v1/profile/' do

      get 'Display user you are logged in as' do
        tags 'Display user you are logged in as'
        consumes 'application/json'
        parameter name: :Authorization, :in => :header, :type => :string 

        response '422', 'no token' do
          let(:Authorization){nil}
          run_test! do
            expect(json["message"]).to eq("Missing token")
          end
        end

        response '200', 'Display current user logged in' do
          run_test! do
            # binding.pry
            expect(json["id"]).to eq(current_user.id)
          end
        end

      end
    end
  end
end

