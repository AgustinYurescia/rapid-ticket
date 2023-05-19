puts "\nLoading places\n"

countries = ['Argentina', 'Paraguay', 'Mexico', 'Bolivia', 'Uruguay', 'Peru']
20.times do
  country = countries.sample
  Place.create(
    city: "Ciudad#{country}_#{rand(1..3000)}",
    state: "Provincia#{country}_#{rand(1..30)}",
    country: country,
    name: FFaker::Company.name,
    address: FFaker::Address.street_address
  )
end
