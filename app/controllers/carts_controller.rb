class CartsController < ApplicationController
  skip_before_action :authorize
  before_action :set_cart, only: %i[ show edit update destroy ]

  # Оператор rescue_from перехватывает исключение, выданное Cart.find().
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_index_url, notice: "Your cart is currently empty" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

  def invalid_cart
    #Свойство logger есть у каждого контроллера. В данном случае мы используем его для записи сообщения в регистрационный уровень error
    logger.error "Attempt to access invalid cart #{params[:id]}"
    # Переадресовываем запрос на отображение каталога, используя метод redirect_to().
    # Аргумент :notice определяет сообщение, которое будет сохранено во флэш-области
    # в качестве уведомления. А зачем нам переадресация, если можно просто отобразить
    # каталог? Если мы применим переадресацию, в браузере будет выставлен URL-адрес
    # магазина, а не http://.../cart/wibble. Таким образом, мы выставляем напоказ
    # меньшую часть нашего приложения, а также оберегаем пользователя от повторного
    # инициирования ошибки в случае перезагрузки страницы
    redirect_to store_index_url, notice: 'Invalid cart'
  end
end
