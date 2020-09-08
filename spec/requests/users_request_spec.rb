require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except("Authorization") }
    let(:valid_params) { attributes_for(:user).to_json  }

    describe '#post /signup' do

        context 'valid params' do
            before { post "/signup", params: valid_params, headers: headers }

            it 'return created message' do
                expect(json['message']).to match(/Account created successfully/)
            end

            it 'have http status 201' do
                expect(response).to have_http_status(201)
            end

            it 'return auth token' do
                expect(json['auth_token']).not_to be_nil
            end

        end

        context 'invalid params' do
            before { post "/signup", params: { }, headers: headers }

            it 'return failure message' do
                expect(json['message']).to match("Validation failed: Password can't be blank, Email can't be blank, Email is invalid, Password digest can't be blank, Password digest is too short (minimum is 5 characters)")
            end

            it 'do not return token' do
                expect(json['auth_token']).to be_nil
            end

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end
        end

    end
end
