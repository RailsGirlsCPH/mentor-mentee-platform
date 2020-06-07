RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { create(:api_user) }
  # valid request subject
  subject(:valid_request_auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_request_auth_obj) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_request_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_request_auth_obj.call }
          .to raise_error(
                ExceptionHandler::AuthenticationError,
                /Invalid credentials/
              )
      end
    end
  end
end
