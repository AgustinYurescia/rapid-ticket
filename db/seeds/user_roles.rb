puts "\nLoading user roles\n"

user_roles = ['Admin', 'User']
user_roles.each do |role|
  UserRole.create(name: role)
end
