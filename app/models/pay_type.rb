class PayType < ApplicationRecord
  def ids
    PayType.all.pluck(:id)
  end
end
