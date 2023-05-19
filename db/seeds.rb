# frozen_string_literal: true

require 'ffaker'

return if Rails.env.test?

puts "Starting data seed\n"

seeds =  [
  'user_roles',
  'users',
  'places',
  'locations',
  'shows',
  'sections',
  'section_locations',
]

seeds.each do |seed|
  load("db/seeds/#{seed}.rb")
end

puts "Seed completed successfully\n"
