# Tanbou Maps - 新しい旅のために

## Programming Environments

- Ruby 3.1.6
- Node.js 22.11.0
- PostgreSQL 17

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

下記コマンドで正常に開発用ローカルサーバーが立ち上がったら成功

```shell
bundle exec rails server
```
