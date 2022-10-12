class LineItem < ApplicationRecord
  # позиция товара не сможет существовать без товара и корзины
  # другими словами, если таблица содержит внешние ключи, тогда
  # используем belongs_to
  # также будут доступны методы carts() и products() для объектов LineItem
  belongs_to :product
  belongs_to :cart
end