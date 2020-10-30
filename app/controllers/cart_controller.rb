class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def add_quantity
    item = Item.find(params[:item_id])
    if cart.contents[item.id.to_s] < item.inventory
      cart.add_item(item.id.to_s)
      redirect_to '/cart'
    else
      redirect_to '/cart'
    end
  end

  def sub_quantity
    item = Item.find(params[:item_id])
    cart.sub_item(item.id.to_s)
    if cart.contents[item.id.to_s] == 0
      remove_item
    else
      redirect_to '/cart'
    end
  end

  def show
    if current_admin?
      render file: '/public/404'
    else
      @items = cart.items
    end
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end


end
