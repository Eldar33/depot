class LineItem < ApplicationRecord
  # позиция товара не сможет существовать без товара и корзины
  # другими словами, если таблица содержит внешние ключи, тогда
  # используем belongs_to
  # также будут доступны методы carts() и products() для объектов LineItem
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  def total_price
    product.price * quantity
  end
end
