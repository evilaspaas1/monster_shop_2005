class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
  end

  def index
    @merchant = current_user.merchant
  end

  def new
    @item = Item.new
  end

  def create
    @merchant = current_user.merchant
    binding.pry
    test = @merchant.items.create(item_params)
  end

  def disable
    item = Item.find(params[:item_id])
    item.update(active?: false)
    flash[:notice] = "#{item.name} is no longer for Sale"
    redirect_to '/merchant/items'
  end

  def activate
    item = Item.find(params[:item_id])
    item.update(active?: true)
    flash[:notice] = "#{item.name} is Available for Sale"
    redirect_to '/merchant/items'
  end

  def destroy
    item = Item.find(params[:item_id])
    item.delete
    redirect_to '/merchant/items'
  end

  private
  def item_params
  params.require(:items).permit(:name, :description, :price, :image, :inventory)
  end
end
