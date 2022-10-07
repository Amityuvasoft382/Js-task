Rails.application.routes.draw do
  root 'users#index'
  resources :users do 
    collection { post :import }
    collection do 
      get 'do_search'
      get 'page_show' 
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
