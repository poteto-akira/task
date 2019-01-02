Rails.application.routes.draw do

  get 'session/new'

# タスク関連
  get '/' => "post#index"
  get "post/new" => "post#new"
  get "post/show/:id" => "post#show"
  get "post/edit/:id" => "post#edit"
  post "post/update/:id" => "post#update"
  post "post/create" => "post#create"
  post "post/destroy/:id" => "post#destroy"
  get "post/next/:id" => "post#next"
  post "post/next/:id" => "post#next"
  get "post/back/:id" => "post#back"
  post "post/back/:id" => "post#back"
  get "post/search" => "post#search"

# ユーザー関連
  get "user/show/:id" => "user#show"
  get "user/edit/:id" => "user#edit"
  patch "user/update/:id" => "user#update"
  delete "user/delete/:id" => "user#destroy"
  get "user/new" => "user#new"
  post "user/new" => "user#create"
  post "user/create" => "user#create"
  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#destroy"



end
