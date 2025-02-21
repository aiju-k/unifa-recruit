class SessionsController < ApplicationController
  def new
  end

  def create
    @errors = []

    login_id = session_params["login_id"]
    if login_id.blank?
      @errors.push("ユーザーIDを入力してください。")
    end

    password = session_params["password"]
    if password.blank?
      @errors.push("パスワードを入力してください。")
    end

    unless @errors.blank?
      login_error()
      return
    end

    user = User.find_by(login_id:)&.authenticate(password)

    if user
      login(user)
      redirect_to pictures_path
    else
      login_error("ユーザーIDまたはパスワードが間違っています。確認してください。")
    end
  end

  def destroy
    logout(@current_user)
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:login_id, :password)
  end

  def login_error(message = nil)
    @errors.push(message) if message
    render action: :new
  end
end
