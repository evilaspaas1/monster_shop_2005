class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      session[:user_id] = user.id
      # flash[:login] = "Logged in as #{current_user.name}"
      redirect_user
    else
      flash[:error] = "Either email or password were incorrect"
      redirect_to "/login"
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Good Bye"
    redirect_to root_path
  end

  private
  def redirect_user
    if current_user.role == "default"
      redirect_to "/profile"
    elsif current_employee?
      redirect_to '/merchant'
    else current_admin?
      redirect_to '/admin'
    end
  end
end
