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

  def merchant_index
    @merchants = Merchant.all
  end

  def merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def disable
    merchant = Merchant.find(params[:merchant_id])
    merchant.update(active_status: false)
    merchant.items.update_all(active?: false)
    flash[:notice] = "Merchant #{merchant.name} is now Disabled"
    redirect_to '/admin/merchants'
  end

  def enable
    merchant = Merchant.find(params[:merchant_id])
    merchant.update(active_status: true)
    merchant.items.update_all(active?: true)
    flash[:notice] = "Merchant #{merchant.name} is now Enabled"
    redirect_to '/admin/merchants'
  end
end
