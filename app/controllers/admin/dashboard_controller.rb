class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def users_index

  end
end
