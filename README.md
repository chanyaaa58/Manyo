## Herokuへのデプロイ手順について

1.Herokuにログイン
```
heroku login
```
2.アセットプリコンパイル
```
rails assets:precompile RAILS_ENV=production
```
3.Herokuに新しいアプリケーションを作成
```
heroku create
```
4.コミット
```
git add -A
```
```
git commit -m "コミットメッセージ"
```
5.Heroku buildpackを追加
```
heroku buildpacks:set heroku/ruby
```
```
heroku buildpacks:add --index 1 heroku/nodejs
```
6.Herokuにデプロイ<br>
（step2ブランチの変更内容をHerokuのmasterブランチに反映）
```
git push heroku step2:master
```
***

## Manyoアプリケーション使用テーブルについて

* User

| column | data |
| ---- | ---- |
| id | bigint |
| name | string |
| email | string |
| password_digest | string |


* Task

| column | data |
| ---- | ---- |
| id | bigint |
| list | string |
| detail | string |
| status | integer |
| expired_at | datetime |
| priority | integer |
| user_id | bigint |
| label_id | bigint |

* Labeling

| column | data |
| ---- | ---- |
| id | bigint |
| task_id | bigint |
| label_id | bigint |

* Label

| column | data |
| ---- | ---- |
| id | bigint |
| name | string |
| task_id | bigint |