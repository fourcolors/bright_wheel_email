Rails.application.routes.draw do
  post 'email' => 'email#create'
end
