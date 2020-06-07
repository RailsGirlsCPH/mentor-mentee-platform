RSpec.describe Api::V1::ExperiencesController, type: :request do


  # initialize test data
  let!(:api_user){create(:api_user)}
  let!(:programminglanguage){create(:programminglanguage)}
  let!(:meetinginterval){create(:meetinginterval)}
  let!(:experiences){create_list(:experience,5,api_user_id: api_user.id, programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id)}
  let(:api_user_id){api_user.id}
  let(:id){experiences.first.id}
  let!(:current_user) {api_user}
  let!(:authorization){token_generator(api_user.id)}

  describe 'Experiences API', capture_examples: true do
    path '/api/v1/api_users/{api_user_id}/experiences/' do

      get 'Displays all Experiences for a user' do
        tags 'List all Experiencess for a user'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string 
        parameter name: :api_user_id, :in => :path, :type => :string

        response '200', 'list experiences' do
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
    end

    path '/api/v1/api_users/{api_user_id}/experiences/{id}' do
      get 'Displays Experience for a user' do
        tags 'List Experience for a user'
        consumes 'application/json'
        parameter name: :api_user_id, :in => :path, :type => :string
        parameter name: :id, :in => :path, :type => :string
        parameter name: :authorization, :in => :header, :type => :string 
        response '200', 'find an experience belonging to a user' do
          run_test! do
            expect(json["qualification"]).not_to eq(nil)
          end
        end
        response '404', 'experience not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end


    path '/api/v1/profile/experiences/' do
      get 'Display all experiences of user you are logged in as' do
        tags 'Display all experiences of a user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string 

        response '422', 'no token' do
          let(:authorization){nil}
          run_test! do
            expect(json["message"]).to eq("Missing token")
          end
        end

        response '200', 'Display experiences current user logged in' do
          run_test! do
            expect(json.count).to eq(5)
          end
        end
      end



      post 'Create an experience' do
        tags 'Create an experience for an API User'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string     
        parameter name: :experience, in: :body,schema: {
                    type: :object,
                    properties: {
                      available_online: {type: :boolean},
                      available_offline: {type: :boolean},
                      qualification: {type: :string},
                      programminglanguage_id: {type: :integer},
                      meetinginterval_id: {type: :integer}
                    },
                    required: ['qualification', 'programminglanguage_id', 'meetinginterval_id']
                  }

        response '201', 'Experience created' do
          let(:experience) {{qualification: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id}}
          run_test! do
            expect([json["qualification"], json["meetinginterval_id"], json["programminglanguage_id"]]).to eq(["Get better at programming",  meetinginterval.id, programminglanguage.id])
          end
        end

        response '422', 'invalid request' do
          let(:experience) {{}}
          run_test! do
            expect(json['message']).to match(/Validation failed: Programminglanguage must exist, Meetinginterval must exist, Qualification can't be blank/)
          end
        end
      end
    end

    path '/api/v1/profile/experiences/{id}/' do
      get 'Display a experience of user you are logged in as' do
        tags 'Display a experience of a user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string 
        parameter name: :id, :in => :path, :type => :string

        response '404', 'Experience not found' do
          let(:id){'invalid'}
          run_test!
        end

        response '200', 'Display experience current user logged in' do
          run_test! do
            expect(json["qualification"]).not_to eq(nil)
          end
        end
      end



      delete 'Deletes  experience from user you are logged in as' do
        tags 'Delete experience from user you are logged in as'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string

        response '204', 'experience deleted' do
          run_test!
        end

        response '404', 'experience not found' do
          let(:id) { 'invalid' }
          run_test!
        end

        context 'Check that experience no longer exists after delete' do
          let(:id) {Experience.create(qualification: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: current_user.id).id}
          let(:updateparams){{id: id, api_user_id: api_user_id}}
          before do
            delete "/api/v1/profile/experiences/#{id}/", headers: {Authorization: "Bearer: #{authorization}"}, params: updateparams, as: :json
            get "/api/v1/profile/experiences/#{id}/", headers: {Authorization: "Bearer: #{authorization}"},  params: updateparams, as: :json
          end
          it 'returns error saying user cannot be found' do
            expect(response.status).to match(404)
          end
        end
      end

      patch 'Update an experience belonging to an API User' do
        tags 'Update an experience belonging to an APi User'
        description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string
        parameter name: :experience, in: :body,schema: {
                    type: :object,
                    properties: {
                      available_online: {type: :boolean},
                      available_offline: {type: :boolean},
                      qualification: {type: :string},
                      programminglanguage_id: {type: :integer},
                      meetinginterval_id: {type: :integer}
                    },
                    required: ['qualification', 'programminglanguage_id', 'meetinginterval_id']
                  }

        response '204', 'programming language updated' do
          let(:experience) {{qualification: 'Get mucho mucho better at programming'}}
          run_test!
        end
        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:experience) {{qualification: 'Get mucho mucho better at programming'}}
          run_test!
        end


        context 'Check that correct updates are made' do
          let(:id) {Experience.create(qualification: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: current_user.id).id}
          let(:newlang){create(:programminglanguage)}
          let(:newinterval){create(:meetinginterval)}
          let(:updateparams) {{qualification: 'Simply the best',  programminglanguage_id: newlang.id, meetinginterval_id: newinterval.id}}
          before do
            patch "/api/v1/profile/experiences/#{id}/", headers: {Authorization: "Bearer: #{authorization}"}, params: updateparams, as: :json
            get "/api/v1/profile/experiences/#{id}/",headers: {Authorization: "Bearer: #{authorization}"},  as: :json
          end
          it 'returns same params as updated' do
            expect([json["qualification"], json["meetinginterval_id"], json["programminglanguage_id"]]).to eq([ "Simply the best",  newinterval.id, newlang.id])
          end
        end
      end
    end
  end
end
