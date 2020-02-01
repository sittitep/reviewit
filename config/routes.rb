Rails.application.routes.draw do
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :auth do
    get 'github/callback' => 'github#callback'
  end

  resource :sessions, only: [:destroy]
  resources :posts, only: [:new, :create, :destroy] do
    member do
      get ':slug' => 'posts#show', as: 'slug'
      post 'resolve' => 'posts#resolve'
      post 'close' => 'posts#close'
    end

    resources :comments, only: [:create, :destroy]
  end

  scope ':originator_type/:originator_id' do
    post 'up' => 'votes#create'
    delete 'down' => 'votes#destroy'
  end
end
