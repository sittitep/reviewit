Rails.application.routes.draw do
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :auth do
    get 'github/callback' => 'github#callback'
  end

  resource :sessions, only: [:destroy]
  resources :posts, only: [:new, :update, :create, :destroy] do
    member do
      post 'resolve' => 'posts#resolve'
      post 'close' => 'posts#close'
    end

    resources :comments, only: [:create, :destroy]
  end

  scope ':originator_type/:originator_id' do
    post 'up' => 'votes#create'
    delete 'down' => 'votes#destroy'
  end

  scope 'b' do
    scope ':branch' do
      root 'posts#index', as: 'branch'
      resources :posts, as: "branch_post", only: [:new, :edit]

      get 'posts/:id/:slug' => 'posts#show', as: 'slug_branch_post'
    end
  end
end
