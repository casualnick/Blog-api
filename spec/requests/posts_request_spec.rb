require 'rails_helper'

RSpec.describe "Posts", type: :request do
    let(:user) { create(:user) }
    let!(:posts) { create_list(:post, 10, user_id: user.id) }
    let(:post_id) { posts.first.id }
    let(:user_id) { user.id }
    let(:headers) { valid_headers }

    describe 'GET /posts' do
        before { get "/users/#{user_id}/posts", params: { }, headers: headers }

        it 'return all posts' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'have http stauts 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'GET /posts/:post_id' do


        context 'post exist' do
            before { get "/users/#{user_id}/posts/#{post_id}", params: { }, headers: headers }

            it 'returnt todo' do
                expect(json['id']).to eq(post_id)
            end

            it 'have http status 200' do
                expect(response).to have_http_status(200)
            end

        end

        context 'post does not exist' do
            let(:post_id) { 0 }
            before { get "/users/#{user_id}/posts/#{post_id}", params: { }, headers: headers }

            it 'return failure message' do
                expect(response.body).to match(/Couldn't find Post/)
            end
            
            it 'have http status 422' do
                expect(response).to have_http_status(404)
            end

        end
    end

    describe 'POST /posts' do
        let(:valid_params) { { title: 'arrow title', content: 'This is a very example content', author: user.id.to_s }.to_json }

        context 'valid params' do
            before { post "/users/#{user_id}/posts", params: valid_params, headers: headers }

            it 'create post ' do
                expect(json['title']).to eq('arrow title')
            end

            it 'have http status 201' do
                expect(response).to have_http_status(201)
            end

        end
        
        context 'invalid params' do
            before { post "/users/#{user_id}/posts", params: {title: nil}.to_json, headers: headers}

            it 'return failure message' do
                expect(response.body).to match(/Title can't be blank/)
            end

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'PUT /posts/:post_id' do
        let(:valid_params) { { title: 'another arrow title'}.to_json }

        context 'valid params' do
            before { put "/users/#{user_id}/posts/#{post_id}", params: valid_params, headers: headers }

            it 'update post properly' do
                updated_post = Post.find(post_id)
                expect(updated_post.title).to eq('another arrow title')
            end

            it 'have http status 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'invalid params' do
            before { put "/users/#{user_id}/posts/#{post_id}", params: { title: nil }.to_json, headers: headers }

            it 'return failure message' do
                expect(response.body).to match(/Title can't be blank/)
            end

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'DELETE /posts/:post_id' do
        before { delete "/users/#{user_id}/posts/#{post_id}", params: { }, headers: headers }

        it 'have http status 204 ' do
            expect(response).to have_http_status(204)
        end
    end
end
