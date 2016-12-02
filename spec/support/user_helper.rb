module UserHelper
  def log_user_in(user)
    current_user = user
    session['user_id'] = user.id
  end
end
