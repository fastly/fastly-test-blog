Rails.application.routes.draw do

  root 'articles#index'

  get 'articles/:id/create-comment', to: "articles#create_comment"

  get '/about', to: 'pages#about'

  resources :articles, only: [:index, :show, :destroy] do
    get 'create_article', on: :new
    resources :comments
  end

end
