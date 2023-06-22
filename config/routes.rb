Rails.application.routes.draw do
  namespace :admin do
    get 'order_items/show'
  end
  namespace :admin do
    get 'orders/show'
  end
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  root to: "homes#top"
  get "/about"=>"homes#about"
  
  namespace :admin do
    root to: "homes#top"
    resources :items,only: [:index,:new,:create,:show,:edit,:update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :show, :edit, :update]
  end
  
  scope module: :customer do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :destroy] 
    resources :orders, only: [:new, :confirm, :thanx, :create, :index, :show]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
end
