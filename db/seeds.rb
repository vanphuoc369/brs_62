User.create!(fullname:  "Quang Dũng", email: "nguyenquangdung5560@gmail.com", password: "112344",
             password_confirmation: "112344", is_admin: true)

19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(fullname:  name, email: email, password: password,
               password_confirmation: password)
end
