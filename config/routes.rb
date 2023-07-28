Rails.application.routes.draw do
  root 'entries#index'
  resources :entries, only: [:index, :create, :new, :edit, :update, :destroy]
end
