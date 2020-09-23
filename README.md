# README

## Task

|  カラム名  |    データ型   |
----|----
| id          | integer  |
| title       | string   |
| content     | string   |
| created_at  | datetime |
| updated_at  | datetime |


## User

|  カラム名  |    データ型   |
----|----
| id              | integer   |
| name            | string   |
| email           | string   |
| password_digest | string |

## Label

|  カラム名  |    データ型   |
----|----
| id   | integer |
| name | string  |

## Labelling

|  カラム名  |    データ型   |
----|----
| id        | integer |
| task_id   | integer |
| label_id  | integer |

## Herokuデプロイ手順
1. デプロイするアプリのディレクトリへ移動
  1.Herokuにログイン
  1.$ heroku login
1.アセットプリコンパイルをする
  1.$ rails assets:precompile RAILS_ENV=production
1.アプリを追加・コミットする
  1.$ git add -A
  1.$ git commit -m "coment"
1.Heroku上にアプリを作成する
  1.$ heroku create
1.Heroku buildpackを追加する
  1.$ heroku buildpacks:set heroku/ruby
  1.$ heroku buildpacks:add --index 1 heroku/nodejs
1.Herokuにデプロイする
  1.マスター；$ git push heroku master
  1.branch：$ git push heroku <ブランチ名>:master
1.データベース移行
  1.$heroku run rails db:migrate
