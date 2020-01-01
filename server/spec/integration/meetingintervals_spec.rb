# spec/integration/meetinginterval_spec.rb
require 'swagger_helper'

describe 'Meetingintervals API' do

  path '/api/v1/meetingintervals/' do

    post 'Creates a meeting interval' do
      tags 'Create a  Meeting Interval'
      consumes 'application/json'
      parameter name: :meetinginterval, in: :body, schema: {
                  type: :object,
                  properties: {
                    interval: {type: :string }
                  },
                  required: [ 'interval' ]
                }

      response '201', 'meeting interval created' do
        let(:meetinginterval) { { interval: 'weekly' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:meetinginterval) { { interval: true} }
        run_test!
      end
    end

    get 'Displays all meeting intervals' do
      tags 'List all Meeting Intervals'
      response '200', 'list meeting intervals' do
        run_test!
      end
    end

  end


  path '/api/v1/meetingintervals/{id}' do

    get 'Retrieves a meeting interval' do
      tags 'Return Meeting Interval'
      consumes 'application/json'
      parameter name: :id,  :in => :path, :type => :string

      response '200', 'meeting interval found' do
        schema type: :object,
          properties: {
            interval: {type: :string }
          },
          required: [ 'interval' ]

        let(:id) { Meetinginterval.create(interval: 'example_weekly').id }
        run_test!
      end

      response '404', 'interval not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end


    delete 'Deletes a meeting interval' do
      tags 'Delete Meeting Interval'
      
      consumes 'application/json'
      parameter name: :id,  :in => :path, :type => :string

      response '204', 'meeting interval deleted' do
        schema type: :object,
               properties: {
                 interval: {type: :string }
               },
               required: [ 'interval' ]

        let(:id) { Meetinginterval.create(interval: 'example_weekly').id }
        run_test!
      end

      response '404', 'interval not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end


    patch 'Update a meeting interval' do
      tags 'Update Meeting Interval'
      description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
      consumes 'application/json'
      parameter name: :id,  :in => :path, :type => :string
      parameter name: :meetinginterval, in: :body, schema: {
                  type: :object,
                  properties: {
                    interval: {type: :string }
                  },
                  required: [ 'interval' ]
                }

      response '204', 'meeting interval updated' do
        schema type: :object,
               properties: {
                 interval: {type: :string }
               },
               required: [ 'interval' ]

        let(:id) { Meetinginterval.create(interval: 'weekly').id }
        let(:meetinginterval) { { interval: 'weekly update' } }
        run_test!
      end

      response '404', 'interval not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end

    end
end
