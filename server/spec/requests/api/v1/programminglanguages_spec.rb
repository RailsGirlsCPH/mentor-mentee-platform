
require 'rails_helper'
RSpec.describe Api::V1::ProgramminglanguagesController do

#describe "Test Programming Lanaguages", :type => :controller do
  it 'test description' do

    get "/api/v1/programminglanguages"

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success


    post "http://localhost:3000/api/v1/programminglanguages/"
            {"language": "MADE UP"}
    # check to make sure the right amount of messages are returned
    #expect(json['messages'].length).to eq(10)
  end
end
