Rails.application.routes.draw do
  # get 'podcasts/index'
  # get 'podcasts/show'
  devise_for :podcasts
  root 'welcome#index'
  resources :podcasts, only: [:index, :show] do
    resources :episodes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
