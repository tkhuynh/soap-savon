Rails.application.routes.draw do

  root to: 'area_codes#index', as: "area_code"

  get "/countries", to: 'countries#index', as: "countries"
end
