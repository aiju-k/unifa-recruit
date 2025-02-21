# 概要

* Ruby on Rails 7.2
* データベース：sqlite 3
* ローカル環境：docker-compose

## 境構築手順

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
