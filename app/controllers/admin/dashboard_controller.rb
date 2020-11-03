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

  def merchant
    @merchant = Merchant.find(params[:merchant_id])
  end 
end
