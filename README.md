# README

## Model name :Task
|  Column |  Type  |
| ------- | ------ |
|  list   | string |
|  detail | string |

* Ruby version :'3.0.1'

### herokuへのデプロイ方法

1. herokuにログイン。
$ heroku login
1. config/route.rbでrootを必ず設定。
1. herokuに新しいアプリケーションを作成。
$ heroku create
1. Gemfileに以下のGemを追加。
  -gem 'net-smtp'
  -gem 'net-imap'
  -gem 'net-pop'
1. $ bundle installを実行。
1. git commitコマンドを使用してコミットを実行。
$ git add .
$ git commit -m "Add gem to deploy Heroku"
1. herokuにデプロイを実行。
※"step2"はローカルのブランチ名。
$ git push heroku step2:master
1. "The Ruby version you are trying to install does not exist on this stack."というエラーが出たら、
Heroku stackのバージョンを下げる。
$ heroku stack:set heroku-20
1. Heroku stackのバージョンを確認。
$ heroku stack
1. heroku-20と確認できたら再度、Herokuにデプロイを実行。
$ git push heroku step2:master
1. "Add the current platform to the lockfile with
remote:`bundle lock --add-platform x86_64-linux` and try again." というエラーメッセージが表示されたら、以下を実行。
$ bundle lock --add-platform x86_64-linux
1. gitへコミット。
$ git add .
$ git commit -m "コメント"
1. herokuへのデプロイを実行。
$ git push heroku step2:master
1. デプロイが成功したら、herokuへDBのマイグレートを実行。
$ heroku run rails db:migrate
1. 以下のコマンドにて、herokuにて正常にアプリが起動するか確認。
$ heroku open