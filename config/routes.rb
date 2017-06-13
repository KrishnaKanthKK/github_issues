Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  post 'welcome/index'

  get 'welcome/next'

  post 'welcome/next'

  get 'welcome/back'

  post 'welcome/back'

  get 'welcome/search'

  post 'welcome/search'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
