require 'rails_helper'

RSpec.describe "Posts", type: :request do
    let!(:user) { create(:user) }
    let!(:posts) { create_list(:post, 10, user_id: user.id) }
    let(:post_id) { posts.first.id }
    let(:user_id) { user.id }

    describe 'GET /users/:user_id/posts' do
        before { get "/users/#{user_id}/posts" }

        context 'user exist' do
            
            it 'return all posts' do
                expect(json.size).to eq(10)
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

    describe 'GET /users/:user_id/posts/:post_id' do
        before { get "/users/#{user_id}/posts/#{post_id}" }

        context 'post exists' do
            
            it 'return post' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(post_id)
            end

            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'post does not exist' do
            let(:post_id) { 0 }

            it 'have http status 404' do
                expect(response).to have_http_status(404)
            end

            it 'return failure message' do
                expect(response.body).to match(/Couldn't find Post/)
            end
        end
    end

    describe 'POST /users/:user_id/posts' do
        let(:valid_params) { { title: 'It is done', content: 'It is simple example text. You will not even spot it, do not disturb yourself' } }

        context 'valid params' do
            before { post "/users/#{user_id}/posts", params: valid_params }

            it 'have http status 201' do
                expect(response).to have_http_status(201)
            end

            it 'create post successfully' do
                expect(json['title']).to eq('It is done')
            end
        end

        context 'invalid params' do
            before { post "/users/#{user_id}/posts", params: { } }

            it 'have http status 422' do
                expect(response).to have_http_status(422)
            end

            it 'return failure message' do
                expect(response.body).to match(/Title can't be blank/)
            end
        end

    end

    describe 'PUT /users/:user_id/' do
        let(:valid_params) { { title: 'I am the one and you are the second' } }
        before { put "/users/#{user_id}/posts/#{post_id}", params: valid_params }

        context 'post exists' do

            it 'have http status 204 ' do
                expect(response).to have_http_status(204)
            end

            it 'update post properly' do
                updated_post = Post.find(post_id)
                expect(updated_post.title).to match("I am the one and you are the second")
            end
        end

        context 'post does not exist' do
            let(:post_id) { 0 }

            it 'have http status 404' do
                expect(response).to have_http_status(404)
            end

            it 'reutrn not found failure message' do
                expect(response.body).to match(/Couldn't find Post/)
            end
        end
    end

    describe 'DELETE /users/:user_id/posts/:post_id' do
        before { delete "/users/#{user_id}/posts/#{post_id}" }

        it 'have http status 204' do
            expect(response).to have_http_status(204)
        end
    end
end
