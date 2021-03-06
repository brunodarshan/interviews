# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :offers

    root to: 'offers#index'
  end

  resources :offers, path: '/', only: %i[index show]
end
