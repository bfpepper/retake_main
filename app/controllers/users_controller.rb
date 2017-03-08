class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:notice] = "Welcome! You've successfully signed up!"
    else
      deal_with_errors(params)
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def deal_with_errors(params)
    user = params["user"]
    if user["password_confirmation"].empty? || user["password"].empty?
      redirect_to new_user_path
      flash[:notice] = "Sorry, we weren't able to sign you up.\nPlease confirm your password."
    elsif user["email"].empty?
      redirect_to new_user_path
      flash[:notice] = "Sorry, we weren't able to sign you up.\nPlease enter your email address."
    elsif user["password"] != user["password_confirmation"]
      redirect_to new_user_path
      flash[:notice] = "Sorry, we weren't able to sign you up.\nYour password confirmation didn't match your password."
    else
      redirect_to new_user_path
      flash[:notice] = "Sorry, we weren't able to sign you up.\nYour email was entered incorrectly."
    end
  end

end
