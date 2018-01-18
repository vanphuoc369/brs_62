class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    return unless @user
    current_user.follow @user
    relationship = Relationship.last
    content = t(".content_follow") << @user.fullname
    new_activity current_user, content, relationship.id, Settings.action_follow
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    return unless relationship
    @user = relationship.followed
    return unless @user
    current_user.unfollow @user
    content = t(".content_unfollow") << @user.fullname
    new_activity current_user, content, relationship.id, Settings.action_unfollow
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
