class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to :root, :notice => "login successful"
    else
      render "new"
    end
  end

  def destroy
    logout
    redirect_to :root, :notice => "logged out"
  end

  private

  def not_authenticated
    redirect_to login_path, :alert => "please login first"
  end
end
