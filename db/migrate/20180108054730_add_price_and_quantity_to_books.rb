class AddPriceAndQuantityToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :price, :float, default: 0
    add_column :books, :quantity, :integer, default: 0
  end
end
