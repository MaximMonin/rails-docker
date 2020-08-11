Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # basic rails home page (delete after)
  get '/' => "rails/welcome#index"
end
