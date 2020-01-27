require 'swagger_helper'
require 'rails_helper'
RSpec.describe Api::V1::WishesController, type: :request do


  # initialize test data
  let!(:api_user){create(:api_user)}
  let!(:programminglanguage){create(:programminglanguage)}
  let!(:meetinginterval){create(:meetinginterval)}
  let!(:wishes){create_list(:wish,5,api_user_id: api_user.id, programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id)}
  let(:api_user_id){api_user.id}
  let(:id){wishes.first.id}

  describe 'Wishes API', capture_examples: true do
    path '/api/v1/api_users/{api_user_id}/wishes/' do

      get 'Displays all Wishes for a user' do
        tags 'List all Wishes for a user'
        consumes 'application/json'
        parameter name: :api_user_id, :in => :path, :type => :string

        response '200', 'list wishes' do
          run_test! do
            expect(json.size).to eq(5)
          end
        end
        response '404', 'interval not found' do
          let(:api_user_id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
          end
        end
      end



      post 'Create a wish' do
        tags 'Create a wish for an API User'
        consumes 'application/json'
        parameter name: :api_user_id,  :in => :path, :type => :string
        parameter name: :wish, in: :body,schema: {
                    type: :object,
                    properties: {
                      available_online: {type: :boolean},
                      available_offline: {type: :boolean},
                      goal: {type: :string},
                      programminglanguage_id: {type: :integer},
                      meetinginterval_id: {type: :integer}
                    },
                    required: ['goal', 'programminglanguage_id', 'meetinginterval_id']
                  }

        response '201', 'user created' do
          let(:wish) {{goal: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id}}
          run_test! do
            expect([json["goal"], json["meetinginterval_id"], json["programminglanguage_id"]]).to eq(["Get better at programming",  meetinginterval.id, programminglanguage.id])
          end
        end

        response '422', 'invalid request' do
          let(:wish) {{}}
          run_test! do
            expect(json['message']).to match(/Validation failed: Programminglanguage must exist, Meetinginterval must exist, Goal can't be blank/)
          end
        end

        response '422', 'required field, eg. password, can not be blank' do
          let(:wish) {{goal: 'Get better at programming', programminglanguage_id: "0", meetinginterval_id: "0"}}
          run_test! do
            expect(json['message']).to match(/Validation failed: Programminglanguage must exist, Meetinginterval must exist/)
          end
        end
      end
    end
    path '/api/v1/api_users/{api_user_id}/wishes/{id}' do

      get 'Displays Wish for a user' do
        tags 'List Wish for a user'
        consumes 'application/json'
        parameter name: :api_user_id, :in => :path, :type => :string
        parameter name: :id, :in => :path, :type => :string

        response '200', 'find a wish belonging to a user' do
          run_test!
        end
      end

      delete 'Deletes  wish from a user' do
        tags 'Delete wish from a user'
        consumes 'application/json'
        parameter name: :api_user_id,  :in => :path, :type => :string
        parameter name: :id,  :in => :path, :type => :string

        response '204', 'wish deleted' do
          run_test!
        end

        context 'Check that wish no longer exists after delete' do
          let(:id) {Wish.create(goal: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: api_user_id).id}
          let(:updateparams){{id: id, api_user_id: api_user_id}}
          before {delete "/api/v1/api_users/#{api_user_id}/wishes/#{id}/", params: updateparams, as: :json}
          before {get "/api/v1/api_users/#{api_user_id}/wishes/#{id}/", params: updateparams, as: :json}
          it 'returns error saying user cannot be found' do
            #I am not matching error message here as error message strange
            expect(response.status).to match(404)
          end
        end

        response '404', 'wish not found' do
          #I am not matching error message here as error message strange
          let(:id) { 'invalid' }
          run_test!
        end
      end


      patch 'Update a wish belonging to an API User' do
        tags 'Update a wish belonging to an APi User'
        description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :api_user_id,  :in => :path, :type => :string
        parameter name: :id,  :in => :path, :type => :string
        parameter name: :wish, in: :body,schema: {
                    type: :object,
                    properties: {
                      available_online: {type: :boolean},
                      available_offline: {type: :boolean},
                      goal: {type: :string},
                      programminglanguage_id: {type: :integer},
                      meetinginterval_id: {type: :integer}
                    },
                    required: ['goal', 'programminglanguage_id', 'meetinginterval_id']
                  }

        response '204', 'programming language updated' do
          let(:wish) {{goal: 'Get mucho mucho better at programming'}}
          run_test!
        end


        context 'Check that correct updates are made' do
          let(:id) {Wish.create(goal: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: api_user_id).id}
          let(:newlang){create(:programminglanguage)}
          let(:newinterval){create(:meetinginterval)}
          let(:updateparams) {{goal: 'Simply the best',  programminglanguage_id: newlang.id, meetinginterval_id: newinterval.id}}
          before {patch "/api/v1/api_users/#{api_user_id}/wishes/#{id}/", params: updateparams, as: :json}
          before {get "/api/v1/api_users/#{api_user_id}/wishes/#{id}/", as: :json}
          it 'returns same params as updated' do
            expect([json["goal"], json["meetinginterval_id"], json["programminglanguage_id"]]).to eq([ "Simply the best",  newinterval.id, newlang.id])
          end
        end


        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:wish) {{goal: 'Get mucho mucho better at programming'}}
          #I am not matching error message here as error message strange
          run_test!
        end


        response '404', 'user not found' do
          let(:api_user_id) { 'invalid' }
          let(:wish) {{goal: 'Get mucho mucho better at programming'}}
          run_test! do 
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
          end
        end
      end
    end
  end
end
