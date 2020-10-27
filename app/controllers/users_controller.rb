class UsersController<ApplicationController
  def new
    
  end
  
  def create 
    user = User.create(user_params)
    session[:user_id] = user.id
    flash[:logged_in] = "You have successfully registered and logged in."
    redirect_to '/profile'
  end

  def show
    @user = User.find(session[:user_id])
  end 
  
  private
  def user_params
    params.permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :email,
      :password
    )
  end

  
end