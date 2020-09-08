class PostsController < ApplicationController
    before_action :set_user_post
    before_action :set_post, only: [:show, :update, :destroy]

    def index
        json_response(@user.posts)
    end

    def show
        json_response(@post)
    end

    def create
        @post = @user.posts.create!(post_params)
        json_response(@post, :created)
    end

    def update
        @post.update!(post_params)
        json_response(@post, :no_content)
    end
    
    def destroy
        @post.destroy!
        json_response(@post, :no_content)
    end

    private 

    def set_post
        @post = @user.posts.find_by!(id: params[:id]) if @user
    end

    def set_user_post
        @user = User.find(params[:user_id])
    end

    def post_params
        params.permit(:title, :content)
    end
end
