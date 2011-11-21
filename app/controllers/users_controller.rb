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
  
  def email
    @users = User.all
    @user = User.find_by_secreto(params[:id])
    if @user 
      UserMailer.email_link(@user).deliver
      flash.now[:success] = "Email enviado a #{@user.nombre}"
    end
  end
  
  def index
    @users = User.all
  end
  
  def new 
    @user = User.new
    @title = "Nuevo Usuario"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path
    elsif
      @title = "Nuevo Usuario"
      render 'new'
    end
  end
end
