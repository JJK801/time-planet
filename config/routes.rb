Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  post '/webhooks/prismic', to: 'webhooks#prismic'

  # TODO: Find another way to protect this route than admin user
  # require "sidekiq/web"
  # mount Sidekiq::Web => '/sidekiq'
  # authenticate :user, lambda { |u| u.admin } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end
