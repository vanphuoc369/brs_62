User.create!(fullname: "Quang Dũng", email: "nguyenquangdung5560@gmail.com", password: "112344",
             password_confirmation: "112344", is_admin: true)

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
	Book.create!(title: title, author: author, publish_date: publish_date,
		number_of_pages: 50, image: "d.jpg", summary: summary)
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

UserBook.create!(user_id: 1, book_id: 1, is_favorite: 1, status: 0)
