module UsersHelper
  def gravatar_url email
    "http://www.gravatar.com/avatar.php?gravatar_id=" +
      Digest::MD5::hexdigest(email.downcase)
  end

  def current_user
    session[:user]
  end
end
