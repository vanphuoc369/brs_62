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
		number_of_pages: 50, image: "d.jpg", summary: summary, price: 50, quantity: 3)
end
