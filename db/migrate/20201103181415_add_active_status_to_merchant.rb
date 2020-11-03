class AddActiveStatusToMerchant < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :active_status, :boolean, default: true
  end
end
