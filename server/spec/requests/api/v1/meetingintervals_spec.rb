require 'rails_helper'


RSpec.describe Api::V1::MeetingintervalsController, type: :request do

  # initialize test data
  let!(:meetingintervals){create_list(:meetinginterval, 10)}
  let(:meetinginterval_id) {meetingintervals.first.id}

  # Test suite for GET  /api/v1/meetingintervals
  describe 'GET /api/v1/meetingintervals' do
    before {get "/api/v1/meetingintervals"}

    it 'returns meetingintervals' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/meetingintervals/:id
  describe 'GET  /api/v1/meetingintervals/:id' do
    before { get "/api/v1/meetingintervals/#{meetinginterval_id}/" }

    context 'when meetinginterval exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(meetinginterval_id)
      end
    end

    context 'when meetinginterval does not exist' do
      let(:meetinginterval_id) {0}
      before { get "/api/v1/meetingintervals/#{meetinginterval_id}/" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no meeting interval with that id' do
        expect(json['message']).to match(/Couldn't find Meetinginterval with 'id'=#{meetinginterval_id}/)
      end
    end

  end


  # Test suite POST /api/v1/api_user
  describe 'POST /api/v1/meetingintervals' do
    let(:valid_attributes)  { {interval: 'monthlynonsense'}}
  
    context 'when request is valid' do
      before { post '/api/v1/meetingintervals',  params: valid_attributes, as: :json}
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns same params as entered' do
        expect(json['interval']).to eq('monthlynonsense')
      end
    end
  end

  context 'when the request is invalid as no params' do
    let(:invalid_attributes) { { meetinginterval: { interval: nil } }.to_json }
    before { post '/api/v1/meetingintervals', params: invalid_attributes }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(json['message'])
        .to match(/Validation failed: Interval can't be blank/)
    end
  end

  # Test suite for Patch /api/v1/meetingintervals/:id
  describe 'PATCH /api/v1/meetingintervals/:id' do
    let(:valid_attributes) do
      { 'interval': 'firstweek'}
    end
    let(:meetinginterval_id) {meetingintervals.first.id}

    before { patch "/api/v1/meetingintervals/#{meetinginterval_id}/",  params: valid_attributes, as: :json}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    context 'check that parameters have updated correctly' do
      before { get "/api/v1/meetingintervals/#{meetinginterval_id}/",  params: valid_attributes, as: :json}

      it 'returns same params as entered' do
        expect(json["interval"]).to eq('firstweek')
      end
    end

    context 'when meeting interval does not exist' do
      let(:meetinginterval_id) {0}
      let(:valid_attributes) do
        # send json payload
        { 'interval': 'secondweek'}.to_json
      end

      before { patch "/api/v1/meetingintervals/#{meetinginterval_id}/", params: valid_attributes}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no user with that id' do
        expect(json['message']).to match(/Couldn't find Meetinginterval with 'id'=#{meetinginterval_id}/)
      end
    end
  end


    # Test suite for Delete /api/v1/meetingintervals/:id
    describe 'DELETE /api/v1/meetingintervals/:id' do

      context 'when request made to delete an interval' do
        let(:meetinginterval_id) {meetingintervals.first.id}
        before { delete "/api/v1/meetingintervals/#{meetinginterval_id}/" }
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'when meetinginterval does not exist' do
        let(:meetinginterval_id) {0}
        before { delete "/api/v1/meetingintervals/#{meetinginterval_id}/" }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns message informing no user with that id' do
          expect(json['message']).to match(/Couldn't find Meetinginterval with 'id'=#{meetinginterval_id}/)
        end
      end
    end


end
