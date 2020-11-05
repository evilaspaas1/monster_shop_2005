class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders

  belongs_to :user

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def quantity
    items.count
  end

  def grandtotal_by_merchant(merchant_id)
    item_orders.joins(:item).where(items: {merchant_id: merchant_id}).sum('item_orders.price * item_orders.quantity')
  end

  def quantity_by_merchant(merchant_id)
    item_orders.joins(:item).where(items: {merchant_id: merchant_id}).sum(:quantity)
  end

  def cancel_order
    item_orders.where(status: 'fulfilled').each do |order|
      order.item.update(inventory: (order.quantity + order.item.inventory))
    end

    update(status: 'cancelled')
    item_orders.where(order_id: id).update_all(status: 'unfulfilled')
  end

  def all_items_fullfilled
    update(status: "packaged") if item_orders.all? {|item_order| item_order.status == "fulfilled"}
  end

  def merchant_items(merchant_id)
    item_orders.joins(:item).where(items: {merchant_id: merchant_id})
  end
end
