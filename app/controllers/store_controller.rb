class StoreController < ApplicationController
  # пропускаем проверку авторизации в этом контроллере
  skip_before_action :authorize

  include CounterIndexStore
  include CurrentCart

  before_action :increase_counter, only: [:index]
  before_action :set_cart, only: [:index]

  def index
    if params[:set_locale]
     redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
