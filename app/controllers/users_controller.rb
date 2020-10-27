class UsersController<ApplicationController
  def new
    
  end
  
  def create 
    @user = User.create(user_params)
    redirect_to '/profile'
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