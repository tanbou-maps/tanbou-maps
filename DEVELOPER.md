# 開発者向けドキュメント

## 環境構築

### 事前準備

`Ruby 3.1.6` がはいっていることを確認

```shell
ruby -v
```

`bundler` をインストール

```shell
gem install bundler
```

`bundler` がインストールできたことを確認

```shell
bundler -v
```

`Node.js 22.11.0` がインストールされていることを確認

```shell
node -v
```

`npm` がインストールされていることを確認

```shell
npm -v
```

`npm` のグローバル環境に `yarn` をインストール

```shell
npm install -g yarn
```

`yarn` がインストールされていることを確認

```shell
yarn -v
```

`PostgreSQL 17.0` がインストールされていることを確認

```shell
psql --version
```

### GitHub を使った共同コーディング環境の作成

任意のディレクトリに移動
ex.

```shell
cd ~/Documents/Work/Rails
```

次に GitHub からリポジトリをクローンしてローカル環境に取り込む

```shell
git clone https://github.com/tanbou-maps/tanbou-maps.git
```

現在のディレクトリ内に `tanbou-maps` フォルダが作成されているので移動

```shell
cd tanbou-maps
```

`bundler` のインストールパスの設定

```shell
bundle config set path 'vendor/bundle'
```

`Gemfile` 記載の gem を bundler を使ってインストール

```shell
bundle install
```

`package.json` 記載の node_modules を yarn を使ってインストール

```shell
yarn install
```

`/config/database.yml` を作成し下記内容を自分の PostgreSQL のパスワードに変更

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres
  password: # 自身のパスワードをここに記載
  host: localhost

development:
  <<: *default
  database: tanbou-maps_development

test:
  <<: *default
  database: tanbou-maps_test

production:
  <<: *default
  database: tanbou-maps_production
  username: postgres
  password: <%= ENV["MY_APP_DATABASE_PASSWORD"] %>
```

下記コマンドで正常に開発用ローカルサーバーが立ち上がったら成功

```shell
bundle exec rails server
```

## 環境構築

### 事前準備

`Ruby 3.1.6` がはいっていることを確認

```shell
ruby -v
```

`bundler` をインストール

```shell
gem install bundler
```

`bundler` がインストールできたことを確認

```shell
bundler -v
```

`Node.js 22.11.0` がインストールされていることを確認

```shell
node -v
```

`npm` がインストールされていることを確認

```shell
npm -v
```

`npm` のグローバル環境に `yarn` をインストール

```shell
npm install -g yarn
```

`yarn` がインストールされていることを確認

```shell
yarn -v
```

`PostgreSQL 17.0` がインストールされていることを確認

```shell
psql --version
```

### GitHub を使った共同コーディング環境の作成

任意のディレクトリに移動
ex.

```shell
cd ~/Documents/Work/Rails
```

次に GitHub からリポジトリをクローンしてローカル環境に取り込む

```shell
git clone https://github.com/tanbou-maps/tanbou-maps.git
```

現在のディレクトリ内に `tanbou-maps` フォルダが作成されているので移動

```shell
cd tanbou-maps
```

`bundler` のインストールパスの設定

```shell
bundle config set path 'vendor/bundle'
```

`Gemfile` 記載の gem を bundler を使ってインストール

```shell
bundle install
```

`package.json` 記載の node_modules を yarn を使ってインストール

```shell
yarn install
```

`/config/database.yml` を作成し下記内容を自分の PostgreSQL のパスワードに変更

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres
  password: # 自身のパスワードをここに記載
  host: localhost

development:
  <<: *default
  database: tanbou-maps_development

test:
  <<: *default
  database: tanbou-maps_test

production:
  <<: *default
  database: tanbou-maps_production
  username: postgres
  password: <%= ENV["MY_APP_DATABASE_PASSWORD"] %>
```

データベースの生成

```shell
bundle exec rails db:create
```

データベースを `models` を元に生成

```shell
bundle exec rails db:migrate
```

下記コマンドで正常に開発用ローカルサーバーが立ち上がったら成功

```shell
bundle exec rails server
```

## Git/GitHub の使い方

### 参考記事

- commit message の書き方 -> https://qiita.com/konatsu_p/items/dfe199ebe3a7d2010b3e
- commit/push の頻度 -> https://qiita.com/kozyty@github/items/87fa95a236b6142f7c10
- branch 命名規則 -> https://qiita.com/Hashimoto-Noriaki/items/5d990e21351b331d2aa1
- pull request までの流れ -> https://qiita.com/samurai_runner/items/7442521bce2d6ac9330b
- pull request までの流れ -> https://qiita.com/KosukeSone/items/5534cc07d1441d244fc1
- pull request までの流れ(一番わかりやすい) -> https://qiita.com/kuuuuumiiiii/items/42d2d9ed11e3b29c22cf
- リーモトブランチをもとにローカルブランチを作成 -> https://qiita.com/miriwo/items/53b319d3d3a3759b30a7

### Pull Request までの流れ

GitHub の最新の `develop` branch を取得する

```shell
git pull origin develop --rebase
```

現在のブランチを確認

```shell
git branch
```

自分が現在立っているブランチを確認し `main` branch にいる場合は `origin/develop` の情報をもとに `checkout` する

```shell
git checkout -b develop origin/develop
```

branch が `develop` であることを確認

```shell
git branch
```

#### Git branch naming best practices

| Branch Name | Role                                                                                         | Derivation | Marge to                                                               |
| ----------- | -------------------------------------------------------------------------------------------- | ---------- | ---------------------------------------------------------------------- |
| main        | 公開するものを置くブランチ                                                                   |            | ここのブランチの環境でリリースされます。ブランチの起点みたいなイメージ |
| develop     | 開発中のものを置くブランチ　(この develop ブランチから feature などブランチを切っていきます) | main       | main                                                                   |
| feature-\*  | 新機能開発中に使うブランチ                                                                   | develop    | develop                                                                |
| hotfix-\*   | 公開中のもののバグ修正用ブランチ                                                             | develop    | develop                                                                |

作業する branch を切る
branch の命名規則は下記の通りとして、英語の小文字で行う
上記の命名規則を基に branch を切る

```shell
git checkout -b feature-*
```

ファイルを変更して変更したファイルを commit する

```shell
git add .
```

#### Git commit message best practices

##### Type List

type は 下記のリストから選ぶ

**type が複数にまたがってしまう場合は commit の粒度が大きすぎるので commit の頻度をあげたほうが良い**

- feat: 新機能
- fix: バグの修正
- docs: ドキュメントの変更のみ
- style: コードの意味に影響しない変更（空白、書式、セミコロンの欠落など）
- refactor: バグ修正でも機能追加でもないコード変更
- perf: パフォーマンスを向上させるコード変更
- test: 不足しているテストの追加、または既存のテストの修正
- chore: ドキュメントの生成など、ビルド・プロセスや補助ツール、ライブラリの変更

##### Description

description は日本語で簡潔かつ具体的に 100 文字以内書く

```shell
git commit -m "<type>: <description>"
```

GitHub に push する

```shell
git push origin feature-*
```

https://github.com/tanbou-maps/tanbou-maps

**上記リンク先の GitHub にて Pull Request を作成する**

```txt
merge する先 は "develop" branch であることに気を付ける
リーダーの review と merge を待つ
push した branch が accept された場合は push した リモートの branch を削除する
```

branch を `develop` に変更する

```shell
git checkout develop
```

ローカルの `develop` branch をリモートの最新に更新する

```shell
git pull origin develop --rebase
```

ローカルの branch を削除する

```shell
git branch -d feature-foobar
```

エラーなく正常にできたら OK

## プロジェクト文書フォーマット

### Code Comment / Commit Message / Pull Request

### 日本語を使う場面での注意点

- 丁寧な日本語を心がける
- 全角空白や全角記号を使わない
- 句読点は使用しない方針で統一
- 改行を適切に使って対応する
- 英単語が文中に出現する場合はその英単語の前後に空白を入れる
