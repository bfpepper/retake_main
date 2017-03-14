class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user and @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:notice] = "You Successfully Logged in!"
    else
      deal_with_session_errors
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
    flash[:notice] = "You Successfully Logged out!"
  end


  private

  def deal_with_session_errors
    if params[:session][:password].empty?
      redirect_to login_path
      flash[:notice] = "Sorry, we weren't able to log you in.\nPlease enter your password."
    elsif params[:session][:email].empty?
      redirect_to login_path
      flash[:notice] = "Sorry, we weren't able to log you in.\nPlease enter your email address."
    else
      redirect_to login_path
      flash[:notice] = "Sorry, we weren't able to log you in.\nPlease check that your email or password are correct."
    end
  end

end
