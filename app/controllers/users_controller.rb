class UsersController < ApplicationController
  
  def show
    secreto = params[:id]
    @user = User.find_by_secreto(params[:id])
    @amigo = User.find(@user.amigo)
    @title = @user.nombre
  end
  
  def shuffle
    User.shuffle
    redirect_to root_path
  end
  
  def index
    @users = User.all
  end
end
