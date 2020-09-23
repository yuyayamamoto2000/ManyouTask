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
- 1.デプロイするアプリのディレクトリへ移動  
  1-1.Herokuにログイン  
  1-2.$ heroku login  
- 2.アセットプリコンパイルをする  
  2-1.$ rails assets:precompile RAILS_ENV=production  
- 3.アプリを追加・コミットする  
  3-1.$ git add -A  
  3-2.$ git commit -m "coment"  
- 4.Heroku上にアプリを作成する  
  4-1.$ heroku create  
- 5.Heroku buildpackを追加する  
  5-1.$ heroku buildpacks:set heroku/ruby  
  5-2.$ heroku buildpacks:add --index 1 heroku/nodejs  
- 6.Herokuにデプロイする  
  6-1.マスター；$ git push heroku master  
  6-2.branch：$ git push heroku <ブランチ名>:master  
- 7.データベース移行  
  7-1.$heroku run rails db:migrate  
