module ReviewsHelper
  def find_user_review user_id
    user = User.find_by id: user_id
    return user.fullname if user
  end
end
