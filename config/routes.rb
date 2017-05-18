Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount V1::Root => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
