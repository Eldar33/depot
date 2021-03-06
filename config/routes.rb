Rails.application.routes.draw do

  get 'admin' => 'admin#index'
  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'admin/index'
  # get 'session/new'
  # get 'session/create'
  # get 'session/destroy'
  resources :users

  get 'store/index'
  resources :products

  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [:index, :update]

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    
    root 'store#index', as: 'store', via: :all  
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # The priority is based upon order of creation:
  # (Приоритет основан на порядке создания:)
  # first created -> highest priority.
  # (создан первым -> наивысший приоритет.)
  # See how all your routes lay out with "rake routes".
  # (Раскладку всех маршрутов можно увидеть с помощью команды "rake routes".)
  # You can have the root of your site routed with "root"
  # (Корневой маршрут к вашему сайту можно получить с помощью "root")
end
