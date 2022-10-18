class ProductsChannel < ApplicationCable::Channel
  def subscribed
    # Передаем имя потока "products"
    stream_from "products"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
