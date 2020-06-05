RSpec.describe Api::V1::MeetingintervalsController, type: :request do

  # initialize test data
  let!(:api_user){create(:api_user)}
  let(:authorization){token_generator(api_user.id)}
  let!(:meetingintervals){create_list(:meetinginterval, 10)}
  let(:meetinginterval_id) {meetingintervals.first.id}

  describe 'Meeting intervals API', capture_examples: true do

    path '/api/v1/meetingintervals/' do

      get 'Displays all Meeting Intervals' do
        tags 'List all Meeting Intervals'
        parameter name: :authorization, :in => :header, :type => :string
        response '200', 'list meeting intervals' do
          run_test!
        end
      end

      post 'Creates a meeting interval' do
        tags 'Create a  Meeting Interval'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :meetinginterval, in: :body, schema: {
                    type: :object,
                    properties: {
                      interval: {type: :string }
                    },
                    required: [ 'interval' ]
                  }

        response '201', 'meeting interval created' do
          let(:meetinginterval) { { interval: 'fortnightly' } }
          run_test!
        end

        response '201', 'inspect meeting interval creation' do
          let(:meetinginterval) { { interval: 'daily' } }
          run_test! do
            expect(json['interval']).to eq('daily')
          end
        end

        response '422', 'invalid request' do
          let(:meetinginterval) { { } }
          run_test!
        end

        response '422', 'invalid request' do
          let(:meetinginterval) { { } }
          run_test! do
            expect(json['message']).to match(/Validation failed: Interval can't be blank/)
          end
        end
      end
    end

    #Now we test another path;
    path '/api/v1/meetingintervals/{id}' do


      get 'Retrieves a meeting interval' do
        tags 'Return Meeting Interval'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string

        response '200', 'programming interval found' do
          schema type: :object,
                 properties: {
                   interval: {type: :string }
                 },
                 required: [ 'interval' ]

          let(:id) { Meetinginterval.create(interval: 'monthly').id }
          run_test!
        end


        response '200', 'meeting interval found' do
          schema type: :object,
                 properties: {
                   interval: {type: :string }
                 },
                 required: [ 'interval' ]

          let(:id) { Meetinginterval.create(interval: 'Ruby').id }
          run_test! do
            expect(json['id']).to eq(id)
          end
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test!
        end
        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find Meetinginterval with 'id'=#{id}/)
          end
        end
      end

      delete 'Deletes a meeting interval' do
        tags 'Delete Meeting Interval'

        consumes 'application/json'
        parameter name: :id,  :in => :path, :type => :string
        parameter name: :authorization, :in => :header, :type => :string
        response '204', 'meeting interval deleted' do
          let(:id) {Meetinginterval.create(interval: 'annually').id }
          run_test!
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find Meetinginterval with 'id'=#{id}/)
          end
        end
      end


      patch 'Update a meeting interval' do
        tags 'Update Meeting Interval'
        description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string
        parameter name: :meetinginterval, in: :body, schema: {
                    type: :object,
                    properties: {
                      interval: {type: :string }
                    },
                    required: [ 'interval' ]
                  }

        response '204', 'programming interval updated' do
          let(:id) { Meetinginterval.create(interval: 'biweekly').id }
          let(:meetinginterval) { { interval: 'biweekly' } }
          run_test!
        end

        context 'Check Update Worked' do
          #Remember the response does to patch does not give a response. 
          let(:id) { Meetinginterval.create(interval: 'hourly').id }
          before { patch "/api/v1/meetingintervals/#{id}/",headers: {Authorization: "Bearer: #{authorization}"}, params: {interval: "bihourly"}, as: :json }
          before { get "/api/v1/meetingintervals/#{id}/", headers: {Authorization: "Bearer: #{authorization}"}}

          it 'returns same params as entered' do
            expect(json['interval']).to eq('bihourly')
          end
        end


        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          let(:meetinginterval) { { interval: 'Lisp' } }
          run_test!
        end

        response '404', 'interval not found' do
          let(:id) { 'invalid' }
          let(:meetinginterval) { { interval: 'Helm' } }
          run_test! do 
            expect(json['message']).to match(/Couldn't find Meetinginterval with 'id'=#{id}/)
          end
        end
      end

    end
  end
end
