class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def ship
    order = Order.find(params[:order_id])
    order.update!(status: "shipped")
    redirect_to admin_path
  end

  def users_index

  end
end
