class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
  end

  def index 

  end 
end
