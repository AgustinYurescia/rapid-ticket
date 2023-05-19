puts "\nLoading shows\n"

show_types = ['theatre', 'music', 'circus']
100.times do
  place = Place.all.sample
  Show.create(
    day_and_hour: FFaker::Time.between(DateTime.now, DateTime.now + 90),
    name: FFaker::Lorem.words(2).join(' '),
    show_type: show_types.sample,
    place_id: place.id
  )
end
