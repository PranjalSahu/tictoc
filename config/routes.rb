Rails.application.routes.draw do
  resources :homes
  get 'handle_move' => 'application#handle_move'
end
