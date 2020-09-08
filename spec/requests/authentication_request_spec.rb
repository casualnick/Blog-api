require 'rails_helper'

RSpec.describe "Authentications", type: :request do
    let(:user) { create(:user) }
    let(:headers) { valid_headers.except("Authorization") }
    let(:valid_parmas) do 
        { 
        email: user.email,
        password: user.password
    }.to_json
    end
    let(:invalid_params) do 
        {
        email: 'foo@bar.com',
        password: 'nocontent'
    }.to_json
    end 

    describe '#post auth/login' do

        context 'valid params ' do
            before { post '/auth/login', params: valid_parmas, headers: headers }

            it 'return token' do
                expect(json['auth_token']).not_to be_empty
            end

        end

        context 'invalid params' do
            before { post '/auth/login', params: invalid_params, headers: headers }

            it 'do not return token' do
                expect(json['auth_token']).to be_nil
            end
            
            it 'return failure message' do
                expect(json['message']).to match(/Invalid credentials/)
            end
        end
    end
end
