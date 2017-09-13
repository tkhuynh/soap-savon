Rails.application.routes.draw do

  root to: 'countries#index', as: "countries"

  get "/area_code", to: 'area_codes#index', as: "area_code"

  get "/country", to: 'countries#country', as: "country"

end
