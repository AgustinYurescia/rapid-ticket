puts "\nLoading sections\n"



Section.all.each do |section|
  section.show.place.locations
end