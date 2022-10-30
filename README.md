# README

## Model name :Task
|  Column |  Type  |
| ------- | ------ |
|  list   | string |
|  detail | string |

* Ruby version :'3.0.1'

### herokuへのデプロイ方法

1. herokuにログイン。
<p>$ heroku login</p>
1. config/route.rbでrootを必ず設定。
1. herokuに新しいアプリケーションを作成。
<p>$ heroku create</p>
1. Gemfileに以下のGemを追加。
<p>gem 'net-smtp'</p>
<p>gem 'net-imap'</p>
<p>gem 'net-pop'</p>
1. $ bundle installを実行。
1. git commitコマンドを使用してコミットを実行。
<p>$ git add .</p>
<p>$ git commit -m "Add gem to deploy Heroku"</p>
1. herokuにデプロイを実行。
※"step2"はローカルのブランチ名。
<p>$ git push heroku step2:master</p>
1. "The Ruby version you are trying to install does not exist on this stack."というエラーが出たら、
Heroku stackのバージョンを下げる。
<p>$ heroku stack:set heroku-20</p>
1. Heroku stackのバージョンを確認。
<p>$ heroku stack</p>
1. heroku-20と確認できたら再度、Herokuにデプロイを実行。
<p>$ git push heroku step2:master</p>
1. "Add the current platform to the lockfile with
remote:`bundle lock --add-platform x86_64-linux` and try again." というエラーメッセージが表示されたら、以下を実行。
<p>$ bundle lock --add-platform x86_64-linux</p>
1. gitへコミット。
<p>$ git add .</p>
<p>$ git commit -m "コメント"</p>
1. herokuへのデプロイを実行。
<p>$ git push heroku step2:master</p>
1. デプロイが成功したら、herokuへDBのマイグレートを実行。
<p>$ heroku run rails db:migrate</p>
1. 以下のコマンドにて、herokuにて正常にアプリが起動するか確認。
<p>$ heroku open</p>