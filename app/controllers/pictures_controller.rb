class PicturesController < ApplicationController
  include ActiveStorage::SetCurrent

  before_action :authenticate_user!
  before_action :set_picture, only: [ :tweet ]

  def index
    @pictures = current_user.pictures.order(id: :desc)
  end

  def create
    @errors = []

    @picture = current_user.pictures.build(picture_params)

    title = picture_params["title"]
    if title.blank?
      @errors.push("タイトルを入力してください。")
    end

    image = picture_params["image"]
    if image.blank?
      @errors.push ("画像ファイルを選択してください。")
    end

    unless @errors.blank?
      create_error()
      return
    end

    begin
      ActiveRecord::Base.transaction do
        @picture.save!
      end

      redirect_to pictures_path
    rescue ActiveRecord::RecordInvalid => e
      create_error(e.record.errors.full_messages)
      nil
    end
  end

  def tweet
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{session[:access_token]}"
    }

    params = {
      text: @picture.title,
      url: @picture.image.url
    }
    response = HttpRequestBase.new().post_request(ENV["TWEET_BASE_URL"], params, headers)

    redirect_to pictures_path
  end

  private

  def set_picture
    @picture = current_user.pictures.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to pictures_path
  end

  def picture_params
    params.require(:picture).permit(:title, :image)
  end

  def create_error(message = nil)
    @errors.push(message) if message
    @errors.flatten!
    render action: :new
  end
end
