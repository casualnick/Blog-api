class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    skip_before_action :authorize_request, only: :create

    def index
        @users = User.all
        json_response(@users)
    end

    def show
        json_response(@user)
    end

    def create
        @user = User.create!(user_params)
        auth_token = AuthenticateUser.new(@user.email, @user.password).call
        response = { message: Message.account_created, auth_token: auth_token }
        json_response(response, :created)
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

