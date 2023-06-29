Rails.application.routes.draw do
  namespace :admin do
    get 'order_items/show'
  end
  namespace :admin do
    get 'orders/show'
  end
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  #管理者側のルーティング
  namespace :admin do
    get "/" => "homes#top"
    get "search" => "searches#search"
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update] do
      member do
        get "order"
      end
    end
    resources :orders, only: [:show,:update]
    resources :order_items, only:[:update]
  end
  
  # 会員側のルーティング
  scope module: :public do
    # homes
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get "search" => "searches#search"
    get 'items/:id/genre_search' => 'items#genre_search', as: 'genre_search'
    # items
    resources :items, only: [:index, :show]
    # customers
    get  '/customers/information' => 'customers#show'
    get  '/customers/information/edit' => 'customers#edit'
    patch  '/customers/information' => 'customers#update'
    get  '/customers/unsubscribe' => 'customers#unsubscribe'
    patch  '/customers/withdraw' => 'customers#withdraw'
    # cart_items
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    # orders
    get 'orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanx'
      end
    end
    # shipping_addresses
    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  end
end
