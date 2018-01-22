19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(fullname:  name, email: email, password: password,
               password_confirmation: password)
end

vanhoc = Category.create!(name: "Sách văn học", type_id: 0)
kinhte = Category.create!(name: "Sách kinh tế", type_id: 0)

tieuthuyet = Category.create!(name: "Tiểu thuyết tình cảm", type_id: 1)
trinhtham = Category.create!(name: "Truyện trinh thám", type_id: 1)

kinhdoanh = Category.create!(name: "Sách kinh doanh", type_id: 2)
quantri = Category.create!(name: "Sách quản trị, lãnh đạo", type_id: 2)
