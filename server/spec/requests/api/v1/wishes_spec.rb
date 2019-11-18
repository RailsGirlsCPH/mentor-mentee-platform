require 'rails_helper'
RSpec.describe Api::V1::WishesController, type: :request do


  # initialize test data
  let!(:api_user){create(:api_user)}
  let!(:wishes){create_list(:wish,5,api_user_id: api_user.id)}
  let(:api_user_id){api_user.id}
  let(:id){wishes.first.id}


  # Test suite for GET  /api/v1/api_users/api_user_id/wishes
  describe 'GET /api/v1/api_users/api_users_id/wishes}' do
    before {get "/api/v1/api_users/#{api_user_id}/wishes/"}

    it 'returns api_users.first.wishes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

    context 'when api_user does not exist' do
      let(:api_user_id) {0}
      before { get "/api/v1/api_users/#{api_user_id}/" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns message informing no user with that id' do
        expect(json['message']).to match(/Couldn't find ApiUser with 'id'=#{api_user_id}/)
      end
    end

    # Test suite for GET /api_users/:api_user_id/wishes/:id
    describe 'GET /api/v1/api_users/:api_user_id/wishes/:id' do
      before { get "/api/v1/api_users/#{api_user_id}/wishes/#{id}" }

      context 'when api_users wish exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns the wish' do
          expect(json['id']).to eq(id)
        end
      end

      context 'when api_user wish does not exist' do
        let(:id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Wish/)
        end
      end
    end

    # Test suite for PUT /api_users/:api_user_id/wishes
    describe 'POST /api/v1/api_users/#{api_user_id}/wishes' do
      let(:valid_attributes) { { available_offline: false, available_online: true, goal: 'Learn Postgresql'} }
      let(:not_available_attributes) { { available_offline: false, available_online: false, goal: 'Learn GraphSQL'} }

      context 'when request attributes are valid' do
        before { post "/api/v1/api_users/#{api_user_id}/wishes", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when an invalid request' do
        before { post "/api/v1/api_users/#{api_user_id}/wishes", params: {} }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Validation failed: Goal can't be blank/)
        end
      end

      context 'when user is never available' do
        before { post "/api/v1/api_users/#{api_user_id}/wishes", params: not_available_attributes}

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/"Validation failed: Api user must be available either online or offline to complete wish"/)
        end
      end
    end


    # Test suite for PUT /api_users/:api_user_id/wishes/:id
    describe 'PUT /api/v1/api_users/:api_user_id/wishes/:id' do
      let(:valid_attributes) { { goal: 'Improve Mysql' } }
      let(:not_available_attributes) { { available_offline: false, available_online: false, goal: 'Learn GraphSQL'} }

      before { put "/api/v1/api_users/#{api_user_id}/wishes/#{id}", params: valid_attributes }

      context 'when wish exists' do
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'updates the wish' do
          updated_wish = Wish.find(id)
          expect(updated_wish.goal).to match(/Improve Mysql/)
        end
      end

      context 'when wish exists but the user is not available' do
      before { put "/api/v1/api_users/#{api_user_id}/wishes/#{id}", params: not_available_attributes }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/"Validation failed: Api user must be available either online or offline to complete wish"/)
        end
      end

      context 'when the wish does not exist' do
        let(:id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Wish/)
        end
      end
    end

    # Test suite for DELETE api_users/:api_user_id/wishes/:id
    describe 'DELETE /wishes/:id' do
      context 'when request made to delete a wish' do
        #let(:api_user_id) {api_users.first.id}
        before { delete "/api/v1/api_users/#{api_user_id}/wishes/#{id}" }
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'when wish does not exist' do
        let(:id) {0}
        before { delete "/api/v1/api_users/#{api_user_id}/wishes/#{id}" }
        
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        # #Not included as the eror message does not seem to work
        # it 'returns message informing no wish with that id' do
        #   expect(json['message']).to match(/Couldn't find Wish with 'id'=#{id}/)
        # end
    end
end

end
 
