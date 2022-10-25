class ChangeColumnPayTypeToOrder < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :pay_type, :integer
    rename_column :orders, :pay_type, :pay_type_id
  end
end
