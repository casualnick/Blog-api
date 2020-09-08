class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    def index
        @users = User.all
        json_response(@users)
    end

    def show
        json_response(@user)
    end

    def create
        @user = User.create!(user_params)
        # @user.id = session[:current_user_id]
        json_response(@user, :created)
    end

    def update
        @user.update!(user_params)
        json_response(@user, :no_content)
    end

    def destroy
        @user.destroy!
        json_response(@user, :no_content)
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.permit(:email, :password, :password_confirmation, :name)
    end
end

