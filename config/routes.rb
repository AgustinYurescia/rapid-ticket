# frozen_string_literal: true

Rails.application.routes.draw do
  get '/shows', to: 'shows#index'
  get '/shows/:show_id/get_available_sections', to: 'shows#get_available_sections'
  get '/shows/:show_id/section/:section_id/available_locations', to: 'shows#get_available_locations_for_section'
  post '/reservations/new', to: 'reservations#new_reservation'
end
