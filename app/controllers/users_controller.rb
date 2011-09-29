class UsersController < ApplicationController
  
  def show
    secreto = params[:id]
    @user = User.find_by_secreto(params[:id])
    @user.generate_friend unless @user.amigo
    @amigo = User.find(@user.amigo)
    @title = @user.nombre
  end
  
  def index
    @users = User.all
  end
end
