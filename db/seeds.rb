19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(fullname:  name, email: email, password: password,
               password_confirmation: password)
end

tiengviet = Category.create!(name: "Sách tiếng Việt", type_id: 0)
tienganh = Category.create!(name: "Sách tiếng Anh", type_id: 0)
