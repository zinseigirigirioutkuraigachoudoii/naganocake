Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  root to: "homes#top"
  get "home/about"=>"homes#about"
  
  namespace :admin do
    resources :items,only: [:index,:new,:create,:show,:edit,:update]
  end
end
