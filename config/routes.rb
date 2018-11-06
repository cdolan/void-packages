Rails.application.routes.draw do
  root to: "searches#new"

  resources :searches, only: :new
  resources :packages, only: :show, param: :name
end
