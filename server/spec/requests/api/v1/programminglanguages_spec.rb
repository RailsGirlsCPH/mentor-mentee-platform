RSpec.describe Api::V1::ProgramminglanguagesController, type: :request do

  # initialize test data
  let!(:api_user){create(:api_user)}
  let(:authorization){token_generator(api_user.id)}
  let!(:programminglanguages){create_list(:programminglanguage, 10)}
  let(:programminglanguage_id) {programminglanguages.first.id}

  describe 'Programming languages API', capture_examples: true do

    path '/api/v1/programminglanguages/' do

      get 'Displays all Programming Languages' do
        tags 'List all Programming Languages'
        parameter name: :authorization, :in => :header, :type => :string

        response '200', 'list programming languages' do
          run_test!
        end
      end

      post 'Creates a programming language' do
        tags 'Create a  Programming Language'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :programminglanguage, in: :body, schema: {
                    type: :object,
                    properties: {
                      language: {type: :string }
                    },
                    required: [ 'language' ]
                  }

        response '201', 'programming language created' do
          let(:programminglanguage) { { language: 'python' } }
          run_test!
        end

        response '201', 'inspect programming lanaguage creation' do
          let(:programminglanguage) { { language: 'javascript' } }
          run_test! do
            expect(json['language']).to eq('javascript')
          end
        end

        response '422', 'invalid request' do
          let(:programminglanguage) { { } }
          run_test!
        end

        response '422', 'invalid request' do
          let(:programminglanguage) { { } }
          run_test! do
            expect(json['message']).to match(/Validation failed: Language can't be blank/)
          end
        end
      end
    end

    #Now we test another path;
    path '/api/v1/programminglanguages/{id}' do


      get 'Retrieves a programming language' do
        tags 'Return Programming Language'
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string

        response '200', 'programming language found' do
          schema type: :object,
                 properties: {
                   language: {type: :string }
                 },
                 required: [ 'language' ]

          let(:id) { Programminglanguage.create(language: 'Ruby').id }
          run_test!
        end


        response '200', 'programming language found' do
          schema type: :object,
                 properties: {
                   language: {type: :string }
                 },
                 required: [ 'language' ]

          let(:id) { Programminglanguage.create(language: 'Ruby').id }
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
            expect(json['message']).to match(/Couldn't find Programminglanguage with 'id'=#{id}/)
          end
        end
      end

      delete 'Deletes a programming language' do
        tags 'Delete Programmimg Language'

        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string

        response '204', 'pogramming language deleted' do
          let(:id) {Programminglanguage.create(language: 'Rust').id }
          run_test!
        end

        response '404', 'language not found' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '404', 'language not found' do
          let(:id) { 'invalid' }
          run_test! do
            expect(json['message']).to match(/Couldn't find Programminglanguage with 'id'=#{id}/)
          end
        end
      end


      patch 'Update a programming language' do
        tags 'Update Programming Language'
        description "Note that if successful, you do not recieve the updated content back. You will only recieve a 204"
        consumes 'application/json'
        parameter name: :authorization, :in => :header, :type => :string
        parameter name: :id,  :in => :path, :type => :string
        parameter name: :programminglanguage, in: :body, schema: {
                    type: :object,
                    properties: {
                      language: {type: :string }
                    },
                    required: [ 'language' ]
                  }

        response '204', 'programming language updated' do
          let(:id) { Programminglanguage.create(language: 'perl').id }
          let(:programminglanguage) { { language: 'Perl' } }
          run_test!
        end

        context 'Check Update Worked' do
          #Remember the response does to patch does not give a response. 
          let(:id) { Programminglanguage.create(language: 'SQL').id }
          before { patch "/api/v1/programminglanguages/#{id}/", headers: {Authorization: "Bearer: #{authorization}}"}, params: {language: "SQLite"}, as: :json }
          before { get "/api/v1/programminglanguages/#{id}/", headers: {Authorization: "Bearer: #{authorization}}"}}

          it 'returns same params as entered' do
            expect(json['language']).to eq('SQLite')
          end
        end


        response '404', 'language not found' do
          let(:id) { 'invalid' }
          let(:programminglanguage) { { language: 'Lisp' } }
          run_test!
        end

        response '404', 'language not found' do
          let(:id) { 'invalid' }
          let(:programminglanguage) { { language: 'Helm' } }
          run_test! do 
            expect(json['message']).to match(/Couldn't find Programminglanguage with 'id'=#{id}/)
          end
        end
      end

    end
  end
end

