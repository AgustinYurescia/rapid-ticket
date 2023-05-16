# frozen_string_literal: true

Rails.application.routes.draw do
  get '/shows', to: 'shows#index'
  get '/shows/:show_id/available_locations', to: 'shows#get_available_locations'
  post '/tickets/new', to: 'tickets#new_ticket'
end
