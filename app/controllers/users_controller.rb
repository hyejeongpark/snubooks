class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :activate]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if !@user || !@user.save
      render "new"
    else
      render "signedup"
    end
  end

  def new
    @user = User.new
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!

      auto_login @user
      render "activated"
    else
      not_authenticated
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def posts
    @title = "My items"
    @posts = User.find(params[:id]).posts.order(:updated_at => :desc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to(@user)
    else
      render("edit")
    end
  end

  def destroy
    @user = User.find(params[:id])
    logout
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
