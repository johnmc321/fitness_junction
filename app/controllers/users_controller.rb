class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Fitness Junction!" # uses a key called success because there is a class by the same name defined in the Bootstrap CSS (which makes it appear in green)
      redirect_to @user
    else
      render 'new'
    end
  end
end
