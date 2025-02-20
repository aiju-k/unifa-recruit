module SessionsHelper
  def login(user)
    session[:login_id] = user.login_id
  end

  def current_user
    @current_user = User.find_by(login_id: session[:login_id])
  end

  def authenticated?
    current_user.present?
  end
end
