class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all.group_by{|order| order.status}
  end

  def ship
    order = Order.find(params[:order_id])
    order.update!(status: "shipped")
    redirect_to admin_path
  end

  def users_index

  end
end
