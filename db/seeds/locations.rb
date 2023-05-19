puts "\nLoading locations\n"

places = Place.where(id: (1..10).to_a)
places.each do |place|
  for row in ('a'..'j')
    for number in (1..100)
      Location.create!(
        location_number: number,
        location_row: row,
        place_id: place.id
      )
    end
  end
end

places = Place.where(id: (11..20).to_a)
places.each do |place|
  for row in ('a'..'z')
    for number in (1..80)
      Location.create!(
        location_number: number,
        location_row: row,
        place_id: place.id
      )
    end
  end
end
