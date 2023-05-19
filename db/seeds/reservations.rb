users = User.all
shows = Show.all
section_locations = SectionLocation.all
10.times do
  user = users.sample
  show = shows.sample
  reservation = Reservation.create(
    total: FFaker::Number.decimal(l_digits: 2),
    currency: FFaker::Currency.code,
    user: user,
    show: show
  )
  5.times do
    section_location = section_locations.sample
    reservation.section_locations << section_location
  end
end
