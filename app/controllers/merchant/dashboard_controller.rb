class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
  end

  def index
    @merchant = current_user.merchant
  end

  def disable
    item = Item.find(params[:item_id])
    item.update(active?: false)
    flash[:notice] = "#{item.name} is no longer for Sale"
    redirect_to '/merchant/items'
  end
end
