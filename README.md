# README

## Model name :Task
|  Column |  Type  |
| ------- | ------ |
|  list   | string |
|  detail | string |

* Ruby version :'3.0.1'

### herokuへのデプロイ方法

1. herokuにログイン。
<br>$ heroku login
1. config/route.rbでrootを必ず設定。
1. herokuに新しいアプリケーションを作成。
<br>$ heroku create
1. Gemfileに以下のGemを追加。
<br>gem 'net-smtp'
<br>gem 'net-imap'
<br>gem 'net-pop'
1. $ bundle installを実行。
1. git commitコマンドを使用してコミットを実行。
<br>$ git add .
<br>$ git commit -m "Add gem to deploy Heroku"
1. herokuにデプロイを実行。
※"step2"はローカルのブランチ名。
<br>$ git push heroku step2:master
1. "The Ruby version you are trying to install does not exist on this stack."というエラーが出たら、
Heroku stackのバージョンを下げる。
<br>$ heroku stack:set heroku-20
1. Heroku stackのバージョンを確認。
<br>$ heroku stack
1. heroku-20と確認できたら再度、Herokuにデプロイを実行。
<br>$ git push heroku step2:master
1. "Add the current platform to the lockfile with
remote:`bundle lock --add-platform x86_64-linux` and try again." というエラーメッセージが表示されたら、以下を実行。
<br>$ bundle lock --add-platform x86_64-linux
1. gitへコミット。
<br>$ git add .
<br>$ git commit -m "コメント"
1. herokuへのデプロイを実行。
<br>$ git push heroku step2:master
1. デプロイが成功したら、herokuへDBのマイグレートを実行。
<br>$ heroku run rails db:migrate
1. 以下のコマンドにて、herokuにて正常にアプリが起動するか確認。
<br>$ heroku open