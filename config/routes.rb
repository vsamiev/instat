Rails.application.routes.draw do

  constraints subdomain: 'api' do
    namespace :api, path: '/' do
      resources :instats, except: [:new, :edit]
      post "incoming" => "instats#create"
      get 'players/:id' => "instats#show"
    end
  end

end
