class StoreController < ApplicationController

  include CounterIndexStore
  include CurrentCart

  before_action :increase_counter, only: [:index]
  before_action :set_cart, only: [:index]

  def index
    @products = Product.order(:title)
  end
end
