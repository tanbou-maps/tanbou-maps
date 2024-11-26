# 開発者向けドキュメント

## 環境構築

### 事前準備

`Ruby 3.1.6` がはいっていることを確認

```bash
ruby -v
```

`bundler` をインストール

```bash
gem install bundler
```

`bundler` がインストールできたことを確認

```bash
bundler -v
```

`Node.js 22.11.0` がインストールされていることを確認

```bash
node -v
```

`npm` がインストールされていることを確認

```bash
npm -v
```

`npm` のグローバル環境に `yarn` をインストール

```bash
npm install -g yarn
```

`yarn` がインストールされていることを確認

```bash
yarn -v
```

`PostgreSQL 17.0` がインストールされていることを確認

```bash
psql --version
```

### GitHub を使った共同コーディング環境の作成

任意のディレクトリに移動

ルートディレクトリやホームディレクトリの直下は避けたほうが良いのでなにかしらのフォルダを作る

example:

```bash
cd ~/Documents/Work/Rails
```

次に GitHub からリポジトリをクローンしてローカル環境に取り込む

```bash
git clone https://github.com/tanbou-maps/tanbou-maps.git
```

現在のディレクトリ内に `tanbou-maps` フォルダが作成されているので移動

```bash
cd tanbou-maps
```

`bundler` のインストールパスの設定

```bash
bundle config set path 'vendor/bundle'
```

`Gemfile` 記載の gem を bundler を使ってインストール

```bash
bundle install
```

`package.json` 記載の node_modules を yarn を使ってインストール

```bash
yarn install
```

`config` ディレクトリの下に `database.yml` を作成し下記内容をコピーペーストしてコメントの部分を自分の PostgreSQL のパスワードに変更

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

Google Cloud にて Google Maps Platform の API を有効化 して API_KEY を取得する

"bash" を使っている場合:

"vim" を使い `config/credentials.yml.enc` を 編集

```bash
EDITOR="vim" bin/rails credentials:edit
```

"PowerShell" を使っている場合:

Visual Studio Code を `code` コマンドで使えるように環境変数を設定し `config/credentials.yml.enc` を 編集

```shell
$env:EDITOR="code --wait"
bundle exec rails credentials:edit
```

立ち上がった編集画面に以下を追記

```yml
google_maps_api:
  key: "自分のAPIキー"
```

データベースの生成

```bash
bundle exec rails db:create
```

テーブルをカラムを `models` を元に生成

```bash
bundle exec rails db:migrate
```

下記コマンドで正常に開発用ローカルサーバーが立ち上がったら成功

```bash
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
- Remote branch をもとに Local branch を作成 -> https://qiita.com/miriwo/items/53b319d3d3a3759b30a7
- pull request の書き方 -> https://qiita.com/marumaru0113/items/c53db580b812f8f6d4da
- conflicts 解決の仕方 -> https://qiita.com/Hashimoto-Noriaki/items/0bcd4c5592bc1305c145

### Pull Request までの流れ

現在のブランチを確認

```bash
git branch
```

自分が現在立っているブランチを確認し `main` branch にいる場合は `origin/develop` の情報をもとに `checkout` する

```bash
git checkout -b develop origin/develop
```

現在立っている branch に GitHub の最新の `develop` branch を取得する

```bash
git pull origin develop --rebase
```

branch が `develop` であることを確認

```bash
git branch
```

#### Git branch naming best practices

| Branch Name | Role                                                                                         | Derivation | Marge to                                                               |
| ----------- | -------------------------------------------------------------------------------------------- | ---------- | ---------------------------------------------------------------------- |
| main        | 公開するものを置くブランチ                                                                   |            | ここのブランチの環境でリリースされます。ブランチの起点みたいなイメージ |
| develop     | 開発中のものを置くブランチ　(この develop ブランチから feature などブランチを切っていきます) | main       | main                                                                   |
| feature-\*  | 新機能開発中に使うブランチ                                                                   | develop    | develop                                                                |
| hotfix-\*   | 公開中のもののバグ修正用ブランチ                                                             | develop    | develop                                                                |

topic branch の命名規則は上記の通りとして、英語の小文字で行い、ケバブケースで単語をつなぎ上記の命名規則を基に topic branch を切る

```bash
git checkout -b feature-*
```

example:

```bash
git checkout -b feature-user-manage
```

> checkout が無事にできたら コーディング開始

> コーディングは topic branch 上でのみ行う

ファイルを変更して変更したファイルを commit する

```bash
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
- refactor: バグ修正でも機能追加でもないコード変更やコードコメントの追記
- perf: パフォーマンスを向上させるコード変更
- test: 不足しているテストの追加、または既存のテストの修正
- chore: ドキュメントの生成など、ビルド・プロセスや補助ツール、ライブラリの変更

##### Description

上記の "type" から一つ選び と "description" は日本語で簡潔かつ具体的に 100 文字以内書く

```bash
git commit -m "<type>: <description>"
```

example:

```bash
git commit -m "feat: プロフィール編集ができるようにルーティングの設定"
```

GitHub に push する

```bash
git push origin feature-*
```

### Create Pull Request

https://github.com/tanbou-maps/tanbou-maps

**上記リンク先の GitHub にて Pull Request を作成する**

merge する先 は "develop" branch であることに気を付ける

Pull Request を送った時に conflicts が発生していた場合

conflicts の解決をしてから再度 commit と push をして

conflicts のない状態にする

コードレビュワーが conflicts がないことを確認して

commit log にも問題が見受けられなかった場合

コードレビュワーが merge Pull Request をして remote の topic branch を削除するので

Pull Request を送信した人はそれを確認し次第下記の作業を実行する

### After merge Pull Request

branch を `develop` に変更する

```bash
git checkout develop
```

ローカルの `develop` branch をリモートの最新に更新する

```bash
git pull origin develop --rebase
```

ローカルの topic branch を削除する

```bash
git branch -d feature-*
```

example:

```bash
git branch -d feature-user-manage
```

topic branch で作業中に `develop` branch に `Gemfile` や `package.json` に変更があった場合

ライブラリの依存関係を保つために以下のコマンドを実行

gem のインストール

```bash
bundle install
```

node_modules のインストール

```bash
yarn install
```

データベースのマイグレーション

```bash
bundle exec rails db:migrate
```

サーバーの起動

```bash
bundle exec rails server
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
