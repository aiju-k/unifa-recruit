# 概要

* Ruby on Rails 7.2
* データベース：sqlite 3
* ローカル環境：docker-compose

## 環境構築手順

* git clone git@github.com:aiju-k/unifa-recruit.git
* .env ファイルをルートディレクトリに配置
  ```sh
  CLIENT_ID = <OAuthの client_id>
  CLIENT_SECRET = <OAuthの client_secret>

  TWEET_BASE_URL = <ツイートAPIのURL 例: "~.com/api/tweets">
  OAUTH_BASE_URL = <認証APIのURL 例: "~.com/oauth/"> # /oauth 以降のパスは含めない
  ```
* `docker compose build --no-cache`
* `docker compose run --rm web bin/setup`
* `docker compose down`
* `docker compose up -d`
* `http://localhost:3000` へアクセス
* ログインユーザー
  * ユーザーID：`test`
  * パスワード：`password`

## その他

* 所要時間：約10時間
