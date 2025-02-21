module SessionsHelper
  def login(user)
    session[:login_id] = user.login_id
    current_user
  end

  def logout(user)
    session.delete :login_id
    session.delete :access_token
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(login_id: session[:login_id])
  end

  def authenticated?
    current_user.present?
  end
end
