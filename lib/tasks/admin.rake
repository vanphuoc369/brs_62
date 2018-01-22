namespace :admin do
  # desc "TODO"
  task admin_account: :environment do
    User.create!(fullname: "Quang Dũng", email: "nguyenquangdung5560@gmail.com", password: "112344",
      password_confirmation: "112344", is_admin: true)
  end

end
