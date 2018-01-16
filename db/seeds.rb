19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(fullname:  name, email: email, password: password,
               password_confirmation: password)
end

20.times do |n|
  title = "Title-#{n+1}"
  author = "Author-#{n+1}"
  publish_date = Time.zone.now
  summary = "Summary-of-book #{n+1}"
  str = "abcdefghiklm"
  img = str[rand(0..str.length-1)] + ".jpg"
  Book.create!(title: title, author: author, publish_date: publish_date,
    number_of_pages: 50, image: img, summary: summary)
end

vanhoc = Category.create!(name: "Sách văn học", type_id: 0)
lichsu = Category.create!(name: "Sách lịch sử", type_id: 0)

3.times do |n|
  name = "Thể loại văn học #{n+1}"
  Category.create!(name: name, type_id: 1)
end

3.times do |n|
  name = "Thể loại lịch sử #{n+1}"
  Category.create!(name: name, type_id: 2)
end

19.times do |n|
  user_id = n+1
  book_id = rand(1..20)
  content = "Content-#{n+1}"
  rate = rand (1..5)
  Review.create!(user_id: user_id, book_id: book_id, content: content, rate: rate)
end

20.times do |n|
  user_id = 1
  book_id = rand(1..20)
  is_favorite = rand(0..1)
  status = rand(0..2)
  UserBook.create!(user_id: user_id, book_id: book_id, is_favorite: is_favorite,
    status: status)
end
