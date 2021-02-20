# README
## STEP1
#### - モデル名
**カラム名**:データ型  
としています　　
#### - User
**id**  
**name**:string  
#### - Task
**id**  
**title**:string  
**content**:text  
**user_id**:integer  
**label_id**:integer  
#### - Label
**id**  
**label**:integer  
**task_id**:integer  
#### - Task&Label
**task_id**:integer  
**label_id**:integer
## STEP2
### Herokuへのデプロイ手順
bundler ver 2.1.4  
**1.Herokuログイン**  
$ heroku login  
ブラウザが立ち上がるので,アドレスとパスワードを入力  
**2.アセットプリコンパイルを行う**  
$ rails assets:precompile RAILS_ENV=production
**3.heroku上にアプリを作成**  
$ heroku create 'アプリ名(なければ適当な名前が付く)'  
**4.git管理下に置く**  
$ git add -A & $ git commit -m'hoge'  
(追加項目)  
- 最新版のstackだとRuby2.6.5で使用できない場合があるため,heroku-18を使用したい場合は以下を実行  
$ heroku stack:set heroku-18  
- 追加でbuildpackが必要な場合,次のようにコマンドを実行.(rubyを開発言語とし,node.jsのbuildpackを追加する場合)  
$ heroku buildpacks:set heroku/ruby  
$ heroku buildpacks:add --index 1 heroku/nodejs  
**5.Herokuへデータベース移行**  
$ heroku run rails db:migrate  
**6.Herokuへデプロイ**  
$ git push heroku master  
