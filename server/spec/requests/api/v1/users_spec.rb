require 'rails_helper'
RSpec.describe Api::V1::UsersController do
  before(:all) do
    Rails.application.load_seed
  end
  #describe "Test Users", :type => :controller do
  it 'Test we get a success response to GET' do
    get "/api/v1/users"

    json = JSON.parse(response.body)
    print(json)
    # test for the 200 status-code
    expect(response).to be_success
  end

  it "Test GET payload size 3 which matches test database" do
    get "/api/v1/users"
    expect(JSON.parse(response.body)["users"].size).to eq(3)
  end

  it 'Test addition new user, which increases count by 1' do
    expect{post "http://localhost:3000/api/v1/users/", params: {user: {first_name: 'Sue', last_name: 'Titter',email: 'sue@email.com', city: 'Melbourne', mentor: 'True', mentee: 'False'}}}.to change(User, :count).by(+1)
  end

  it 'Test update an existing user and check it was updated' do
    get "/api/v1/users"
    idval = JSON.parse(response.body)["users"][0]["id"].to_s
    patch "/api/v1/users/#{idval}", params: {user: {first_name: 'Robert'}}

    get "/api/v1/users/#{idval}"

    expect(JSON.parse(response.body)["user"]['first_name']).to eql('Robert')
  end

  it 'test deletion of existing user and check it was deleted' do
    get "/api/v1/users"
    idval = JSON.parse(response.body)["users"].select{ |e| e["first_name"]=="Mary"}.first['id']
    delete "/api/v1/users/#{idval}"
    get "/api/v1/users"
    expect(JSON.parse(response.body)["users"].select{ |e| e["first_name"]=="Mary"}).to eq([])
  end
end
