class Api::V1::SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
        #   sign_in user
          render json: { user: user.as_json(only: [:id, :email]) }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
    end

    def destroy
      reset_session
      render json: { message: 'Logout successful' }, status: :ok
    end
end
  