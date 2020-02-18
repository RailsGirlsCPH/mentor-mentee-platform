require 'swagger_helper'
require 'rails_helper'
RSpec.describe Api::V1::ExperiencesController, type: :request do


  # initialize test data
  let!(:api_user){create(:api_user)}
  let!(:programminglanguage){create(:programminglanguage)}
  let!(:meetinginterval){create(:meetinginterval)}
  let!(:experiences){create_list(:experience,5,api_user_id: api_user.id, programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id)}
  let(:api_user_id){api_user.id}
  let(:id){experiences.first.id}

  describe 'Experiences API', capture_examples: true do
    path '/api/v1/api_users/{api_user_id}/experiences/' do

      get 'Displays all Experiences for a user' do
        tags 'List all Experiencess for a user'
        consumes 'application/json'
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



      post 'Create an experience' do
        tags 'Create an experience for an API User'
        consumes 'application/json'
        parameter name: :api_user_id,  :in => :path, :type => :string
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

        response '201', 'user created' do
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

        response '422', 'required field, eg. password, can not be blank' do
          let(:experience) {{qualification: 'Get better at programming', programminglanguage_id: "0", meetinginterval_id: "0"}}
          run_test! do
            expect(json['message']).to match(/Validation failed: Programminglanguage must exist, Meetinginterval must exist/)
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

        response '200', 'find an experience belonging to a user' do
          run_test!
        end
      end

      delete 'Deletes  experience from a user' do
        tags 'Delete experience from a user'
        consumes 'application/json'
        parameter name: :api_user_id,  :in => :path, :type => :string
        parameter name: :id,  :in => :path, :type => :string

        response '204', 'experience deleted' do
          run_test!
        end

        context 'Check that experience no longer exists after delete' do
          let(:id) {Experience.create(qualification: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: api_user_id).id}
          let(:updateparams){{id: id, api_user_id: api_user_id}}
          before {delete "/api/v1/api_users/#{api_user_id}/experiences/#{id}/", params: updateparams, as: :json}
          before {get "/api/v1/api_users/#{api_user_id}/experiences/#{id}/", params: updateparams, as: :json}
          it 'returns error saying user cannot be found' do
            #I am not matching error message here as error message strange
            expect(response.status).to match(404)
          end
        end

        response '404', 'experience not found' do
          #I am not matching error message here as error message strange
          let(:id) { 'invalid' }
          run_test!
        end
      end


      patch 'Update an experience belonging to an API User' do
        tags 'Update an experience belonging to an APi User'
        description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :api_user_id,  :in => :path, :type => :string
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


        context 'Check that correct updates are made' do
          let(:id) {Experience.create(qualification: 'Get better at programming', programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id, api_user_id: api_user_id).id}
          let(:newlang){create(:programminglanguage)}
          let(:newinterval){create(:meetinginterval)}
          let(:updateparams) {{qualification: 'Simply the best',  programminglanguage_id: newlang.id, meetinginterval_id: newinterval.id}}
          before {patch "/api/v1/api_users/#{api_user_id}/experiences/#{id}/", params: updateparams, as: :json}
          before {get "/api/v1/api_users/#{api_user_id}/experiences/#{id}/", as: :json}
          it 'returns same params as updated' do
            expect([json["qualification"], json["meetinginterval_id"], json["programminglanguage_id"]]).to eq([ "Simply the best",  newinterval.id, newlang.id])
          end
        end


        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:experience) {{qualification: 'Get mucho mucho better at programming'}}
          #I am not matching error message here as error message strange
          run_test!
        end


        response '404', 'user not found' do
          let(:api_user_id) { 'invalid' }
          let(:experience) {{qualification: 'Get mucho mucho better at programming'}}
          run_test! do 
            expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
          end
        end
      end
    end
  end
end
