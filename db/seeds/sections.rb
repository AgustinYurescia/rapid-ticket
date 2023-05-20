puts "\nLoading sections\n"

boolean_array = [true, false]
Show.all.each do |show|
  sections_number = (1..3).to_a.sample
  locations_in_groups = show.place.locations.in_groups(sections_number)

  for i in (1..sections_number)
    locations = locations_in_groups[i-1]
    if locations.present? && locations.any?
      section = Section.create!(
        price: FFaker::Number.decimal * 1000,
        currency: 'ARS',
        name: FFaker::Lorem.words,
        show_id: show.id,
        without_numeration: boolean_array.sample,
        available_locations_count: locations.size
      )

      locations.each do |location|
        next if location.nil?
        SectionLocation.create!(section_id: section.id, location_id: location.id)
      end
    end
  end
end
