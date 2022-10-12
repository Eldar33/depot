class Cart < ApplicationRecord
  # В корзине имеется множество позиций товара
  # также доступен метод line_items()
  has_many :line_items, dependent: :destroy
end
