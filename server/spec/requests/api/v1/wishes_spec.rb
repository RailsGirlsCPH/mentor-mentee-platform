RSpec.describe Api::V1::WishesController, type: :request do


  # initialize test data
  let!(:api_user){create(:api_user)}
  let!(:programminglanguage){create(:programminglanguage)}
  let!(:meetinginterval){create(:meetinginterval)}
  let!(:wishes){create_list(:wish,5,api_user_id: api_user.id, programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id)}
  let(:api_user_id){api_user.id}
  let(:id){wishes.first.id}
  let!(:current_user) {api_user}
  let(:authorization){token_generator(api_user.id)}

  describe 'Wishes API', capture_examples: true do
    path '/api/v1/api_users/{api_user_id}/wishes/' do

      get 'Displays all Wishes for a particular user' do
        tags 'List all Wishes for a particular user'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :api_user_id, in: :path, type: :string

        response '200', 'list wishes' do
          run_test! do
            expect(json.size).to eq(5)
          end
        end
        response '404', 'User not found' do
          let(:api_user_id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
          end
        end
      end
    end

    path '/api/v1/api_users/{api_user_id}/wishes/{id}' do

      get 'Displays a Wish for a particular user' do
        tags 'List a Wish for a particular user'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :api_user_id, in: :path, type: :string
        parameter name: :id, in: :path, type: :string

        response '200', 'list wish' do
          run_test! do
            expect(json["goal"]).not_to eq(nil)
          end
        end
        response '404', 'Wish not found' do
          let(:id) { 'invalid' }
          run_test! do
          end
        end
      end
    end



    path '/api/v1/profile/wishes/' do
      get 'Display all  wishes of user you are logged in as' do
        tags 'Display all wishes of a user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, in: :header, type: :string 

        response '422', 'no token' do
          let(:authorization){nil}
          run_test! do
            expect(json["message"]).to eq("Missing token")
          end
        end

        response '200', 'Display wishes current user logged in' do
          run_test! do
            expect(json.count).to eq(5)
          end
        end
      end


      post 'Create a wish for user you are logged in as' do
        tags 'Create a wish for user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, in: :header, type: :string      
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

        response '201', 'Wish created' do
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
      end
    end




    path '/api/v1/profile/wishes/{id}/' do
      get 'Display a wish of user you are logged in as' do
        tags 'Display a wish of a user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, in: :header, type: :string 
        parameter name: :id, in: :path, type: :string

        response '404', 'Wish not found' do
          let(:id){'invalid'}
          run_test!
        end

        response '200', 'Display wishes current user logged in' do
          run_test! do
            expect(json["goal"]).not_to eq(nil)
          end
        end
      end

      delete 'Deletes  wish from user you are logged in as' do
        tags 'Delete wish from user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, in: :header, type: :string 
        parameter name: :id,  in: :path, type: :string

        response '204', 'wish deleted' do
          run_test!
        end

        response '404', 'wish not found' do
          let(:id) {'invalid'}
          run_test!
        end

        context 'Check that wish no longer exists after delete' do
          let(:id) {Wish.create(goal: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: current_user.id).id}
          let(:updateparams){{id: id}}
          before do
            delete "/api/v1/profile/wishes/#{id}/",  headers: {Authorization: "Bearer: #{authorization}"}, params: updateparams, as: :json
            get "/api/v1/profile/wishes/#{id}/", headers: {Authorization: "Bearer: #{authorization}"}, params: updateparams, as: :json
          end
          it 'wish cannot be found' do
            expect(response.status).to match(404)
          end
        end
      end


      patch 'Update a wish belonging to user you are logged in as' do
        tags 'Update a wish belonging to user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, in: :header, type: :string 
        parameter name: :id,  in: :path, type: :string
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

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:wish) {{goal: 'Get mucho mucho better at programming'}}
          run_test!
        end

        context 'Check that correct updates are made' do
          let(:id) {Wish.create(goal: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: current_user.id).id}
          let(:newlang){create(:programminglanguage)}
          let(:newinterval){create(:meetinginterval)}
          let(:updateparams) {{goal: 'Simply the best',  programminglanguage_id: newlang.id, meetinginterval_id: newinterval.id}}
          before do
            patch "/api/v1/profile/wishes/#{id}/",headers: {Authorization: "Bearer: #{authorization}"},  params: updateparams, as: :json
            get "/api/v1/profile/wishes/#{id}/",headers: {Authorization: "Bearer: #{authorization}"},  as: :json
          end
          it 'returns same params as updated' do
            expect([json["goal"], json["meetinginterval_id"], json["programminglanguage_id"]]).to eq([ "Simply the best",  newinterval.id, newlang.id])
          end
        end
      end
    end
  end
end
