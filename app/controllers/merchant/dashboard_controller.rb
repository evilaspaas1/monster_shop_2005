class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
  end

  def index
    @merchant = current_user.merchant
  end

  def new
    @merchant = current_user.merchant
    @item = @merchant.items.new
  end

  def create
    @merchant = current_user.merchant
    @item = @merchant.items.new(item_params)
    if @item.save
      redirect_to '/merchant/items'
      flash[:notice] = "#{@item.name} is Saved"
    else
      flash[:invalid_information] = @item.errors.full_messages.uniq.to_sentence
      render :new
    end
  end

  def edit
    @merchant = current_user.merchant
    @item = @merchant.items.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:item_id])
    if @item.update(item_params)
      redirect_to '/merchant/items'
    else
      flash[:invalid_information] = @item.errors.full_messages.uniq.to_sentence
      render :edit
    end
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

  def order
    @order = Order.find(params[:order_id])
  end

  private
  def item_params
  params.require(:item).permit(:name, :description, :price, :image, :inventory)
  end
end
