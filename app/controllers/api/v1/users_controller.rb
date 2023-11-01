class Api::V1::UsersController < ApplicationController
  def index
    if User.all.empty?
      head :no_content
    else
      render json: UserSerializer.new(User.all)
    end
  end
  
  def show
    user = User.find_by(id: params[:id])
  
    if user.nil?
      head :no_content
    else
      render json: UserSerializer.new(user)
    end
  end
  
  def create
    user = User.from_onmiauth(user_params)
    return nil if !user.save
    render json: UserSerializer.new(user)
  end

  def update
    return nil if !User.exist?(params[:id])
    render json: UserSerializer.new(User.update(params[:id], user_params))
  end

  def destroy
    return nil if !User.exist?(params[:id])
    User.destroy(params[:id])
  end

  private

  def user_params
    if params[:update_user]
      params.require(:update_user).permit(:email)
    else
      a = params.permit(:uid, :provider)
      b = params.require(:credentials).permit(:token, :refresh_token)
      c = params.require(:info).permit(:email)
      a.merge(b).merge(c)
    end
  end
end