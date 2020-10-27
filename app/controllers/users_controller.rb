class UsersController<ApplicationController
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:logged_in] = "You have successfully registered and logged in."
      redirect_to '/profile'
    else 
      flash[:invalid_information] = @user.errors.full_messages.uniq.to_sentence
      render :new
    end 
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