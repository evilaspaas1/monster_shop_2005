class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def fulfill
    update(status: 'fulfilled')
    item.update(inventory: (item.inventory - quantity))
  end
end
