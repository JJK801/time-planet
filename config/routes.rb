Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /[a-z]{2}/ do
    root 'pages#home'
    get 'vision', to: 'pages#vision'
    get 'mentions-legales', to: 'pages#legal', as: 'legal'
    get 'devenir-associee', to: 'pages#become_associate', as: 'become_associate'


    resources :projects, only: [:index, :show], path: 'projets', param: :slug

    get '/contact', to: 'messages#new'
    post '/contact', to:'messages#create'

    # TODO: Find another way to protect this route than admin user
    # require "sidekiq/web"
    # mount Sidekiq::Web => '/sidekiq'
    # authenticate :user, lambda { |u| u.admin } do
    #   mount Sidekiq::Web => '/sidekiq'
    # end
  end
end
