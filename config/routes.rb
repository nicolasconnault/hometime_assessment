Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post '/reservation', to: 'reservation#process_payload'
  end
end
