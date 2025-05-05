admin = User.create!(
  email: "amar2115425@akgec.ac.in",
  password: "password",
  first_name: "Receptionist",
  last_name: "Admin",
  phone_number: "9876543555"
)
admin.add_role(:admin)