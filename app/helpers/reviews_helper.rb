module ReviewsHelper
  def find_user_review user_id
    user = User.find_by id: user_id
    return user.fullname if user
  end

  def review_update? review
    return true if review.created_at < review.updated_at
    false
  end

  def correct_user_review? review
    return true if review.user_id == current_user.id
    false
  end
end
