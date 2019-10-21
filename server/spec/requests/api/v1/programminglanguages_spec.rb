require 'rails_helper'

RSpec.describe Api::V1::ProgramminglanguagesController, type: :request do

  # initialize test data
  let!(:programminglanguages){create_list(:programminglanguage, 10)}
  let(:programminglanguage_id) {programminglanguages.first.id}

  # Test suite for GET  /api/v1/programminglanguages
  describe 'GET /api/v1/programminglanguages' do
    before {get "/api/v1/programminglanguages"}

    it 'returns programminglanguages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/programminglanguages/:id
  describe 'GET  /api/v1/programminglanguages/:id' do
    before { get "/api/v1/programminglanguages/#{programminglanguage_id}/" }

    context 'when programminglanguage exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(programminglanguage_id)
      end
    end

    context 'when programminglanguage does not exist' do
      let(:programminglanguage_id) {0}
      before { get "/api/v1/programminglanguages/#{programminglanguage_id}/" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no meeting interval with that id' do
        expect(json['message']).to match(/Couldn't find Programminglanguage with 'id'=#{programminglanguage_id}/)
      end
    end

  end


    # Test suite POST /api/v1/api_user
  describe 'POST /api/v1/programminglanguages' do
    let(:valid_attributes) do
      # send json payload
      { 'language': 'javascript'}.to_json

      context 'when request is valid' do
        before { post '/api/v1/programminglanguages',  params: valid_attributes}

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'returns same params as entered' do
          expect(json['language']).to eq('javascript')
        end
      end
    end

    context 'when the request is invalid as no params' do
      let(:invalid_attributes) { { programminglanguage: { language: nil } }.to_json }
      before { post '/api/v1/programminglanguages', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Language can't be blank/)
      end
    end
  end


  # Test suite for Patch /api/v1/programminglanguages/:id
  describe 'PATCH /api/v1/programminglanguages/:id' do
        let(:valid_attributes) do
          # send json payload
          { 'language': 'ruby'}.to_json
          let(:programminglanguage_id) {programminglanguages.first.id}

          context 'when request is valid' do
            before { patch "/api/v1/programminglanguages/#{programminglanguage_id}/",  params: valid_attributes}
   
            it 'returns status code 204' do
              expect(response).to have_http_status(204)
            end
          end

          context 'check that parameters have updated correctly' do
            before { get "/api/v1/programminglanguages/#{programminglanguage_id}/",  params: valid_attributes}
          end

          it 'returns same params as entered' do
            expect(json['language']).to eq('ruby')
          end

        end

        context 'when programming language does not exist' do
          let(:programminglanguage_id) {0}
          let(:valid_attributes) do
            # send json payload
            { 'language': 'ruby on rails'}.to_json
            before { patch "/api/v1/programminglanguages/#{programminglanguage_id}/", params: valid_attributes}

            it 'returns status code 404' do
              expect(response).to have_http_status(404)
            end

            it 'returns message informing no user with that id' do
              expect(json['message']).to match(/Couldn't find Programminglanguage with 'id'=#{programminglanguage_id}/)
            end
          end
        end
  end



  # Test suite for Delete /api/v1/programminglanguages/:id
  describe 'DELETE /api/v1/programminglanguages/:id' do

    context 'when request made to delete an interval' do
      let(:programminglanguage_id) {programminglanguages.first.id}
      before { delete "/api/v1/programminglanguages/#{programminglanguage_id}/" }
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when programminglanguage does not exist' do
      let(:programminglanguage_id) {0}
      before { delete "/api/v1/programminglanguages/#{programminglanguage_id}/" }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no user with that id' do
        expect(json['message']).to match(/Couldn't find Programminglanguage with 'id'=#{programminglanguage_id}/)
      end
    end
  end




end
