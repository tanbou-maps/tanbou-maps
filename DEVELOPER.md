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

commit message の書き方 -> https://qiita.com/konatsu_p/items/dfe199ebe3a7d2010b3e
commit/push の頻度 -> https://qiita.com/kozyty@github/items/87fa95a236b6142f7c10
branch 命名規則 -> https://qiita.com/Hashimoto-Noriaki/items/5d990e21351b331d2aa1
pull request までの流れ -> https://qiita.com/samurai_runner/items/7442521bce2d6ac9330b
pull request までの流れ -> https://qiita.com/KosukeSone/items/5534cc07d1441d244fc1
pull request までの流れ(一番わかりやすい) -> https://qiita.com/kuuuuumiiiii/items/42d2d9ed11e3b29c22cf
リーモトブランチをもとにローカルブランチを作成 -> https://qiita.com/miriwo/items/53b319d3d3a3759b30a7

### ベストプラクティス

branch のマージ先は原則 `develop` として `main` にはマージ等行わないようにする

### Pull Request までの流れ
