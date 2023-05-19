puts "\nLoading users\n"

user_role = UserRole.find_by(name: 'User')
20.times do
  User.create(
    name: "#{FFaker::Name.first_name} #{FFaker::Name.last_name}",
    document_number: rand(10000000..99999999).to_s,
    phone_number: "#{100..999}-#{1000000..9999999}",
    user_role_id: user_role.id
  )
end
