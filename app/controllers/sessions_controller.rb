class SessionsController < ApplicationController
  def new
  end
  
  def create
    # TODO: authenticate user

    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["first_name"]}!"
        redirect_to "/posts"
      else
        flash["notice"] = "Incorrect password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "No user found with that email."
      redirect_to "/login"
    end
  end

  def destroy
    # Log out user
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end
  
end
