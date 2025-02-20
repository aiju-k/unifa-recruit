class SessionsController < ApplicationController
  def new
  end

  def create
    errors = []

    login_id = session_params['login_id']
    if login_id.blank?
      errors.push('ユーザーIDを入力してください。')
    end

    password = session_params['password']
    if password.blank?
      errors.push('パスワードを入力してください。')
    end

    unless errors.blank?
      login_error(errors.join(' '))
      return
    end

    user = User.find_by(login_id:)&.authenticate(password)

    if user
      login(user)
      redirect_to pictures_path
    else
      login_error('ユーザーIDまたはパスワードが間違っています。確認してください。')
    end
  end

  private

  def session_params
    params.require(:session).permit(:login_id, :password)
  end

  def login_error(message)
    flash.now[:error] = message
    render action: :new
  end
end
