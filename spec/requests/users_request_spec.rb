require 'rails_helper'

RSpec.describe "Users", type: :request do
    let!(:users) { build_list(:user, 10) }
    let!(:user) { User.create!( email: "example0@email.com", password: "12345678", password_confirmation: "12345678" ) }
    let(:user_id) { user.id }

    before do
        users.each do |user|
            n=1
            user.email = "example#{n}@email.com"
            user.password = "12345678"
            user.password_confirmation = "12345678"
            user.save!
            n += 1
        end

        user.password = "12345678"
        user.password_confirmation = "12345678"
        user.email = "example0@email.com"
    end

    describe 'GET /users' do
        before { get "/users" }

        it 'returns all users' do
            expect(json.size).to eq(11)
            expect(json).not_to be_empty
        end

        it 'have http status 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /users/:user_id' do
        before { get "/users/#{user_id}" }

        context 'user exists' do

            it 'return user' do
                expect(json['id']).to eq(user_id)
            end

            it 'have http status 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'user does not exist' do
            let(:user_id) { 0 }

            it 'have http status 404' do
                expect(response).to have_http_status(404)
            end

            it 'return failure message not found' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    describe 'POST /users' do
        let(:valid_params) { { email: 'example@email.com', password: '12345678', password_confirmation: '12345678', name: 'Derek' }.to_json }

        context 'valid params' do
            before { post "/users", params: valid_params }


            it 'create user' do
                expect(json['email']).to eq('example@email.com')
                expect(json).not_to be_empty
            end

            it 'have http status 201 ' do
                expect(response).to have_http_status(201)
            end
        end

        context 'invalid params' do
            before { post "/users", params: { } }

            it 'return failure message unprocessable entity' do
                expect(response.body).to match(/Email can't be blank/)
            end

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'PUT /users/:user_id' do
        let(:valid_params) { { email: 'example2@email.com', password: "87654321", password_confirmation: "87654321" }.to_json }

        context 'valid params' do
            before { put "/users/#{user_id}", params: valid_params }

            it 'update user properly' do
                updated_user = User.find(user_id)
                puts updated_user.email
                expect(updated_user.email).to eq('example2@email.com')
            end

            it 'return status code 204' do
                expect(response).to have_http_status(204)
            end

        end

        context 'invalid params ' do
            before { put "/users/#{user_id}", params: { }  }

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end

            it 'return failure message unprocessable entity' do
                expect(response.body).to match(/Email can't be blank/)
            end
        end

        describe 'DELETE /users/:user_id' do
            before { delete "/users/#{user_id}" }

            it 'have http status 204' do
                expect(response).to have_http_status(204)
            end
        end
    end
end
