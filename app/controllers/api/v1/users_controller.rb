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
      render json: UserSerializer.new(user, include: [:game_history])
    end
  end
  
  def create
    user = User.new(user_params)
    game_history = GameHistory.create(user: user) if user.save
    render json: UserSerializer.new(user) if user.save
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end 
end