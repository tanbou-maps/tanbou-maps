# lib/tasks/import.rake
namespace :db do
  # タスクの目的を説明 - JSONファイルからユーザーをインポートする
  desc 'Import users from JSON file'

  # Rakeタスク 'import_users' を定義、Rails環境で実行することを指定
  task import_users: :environment do
    # ユーザーデータを含むJSONファイルのパスを設定
    file_path = File.join(Rails.root, 'path', 'to', 'your', 'users.json')

    # ファイルの内容を読み込む
    file = File.read(file_path)

    # 読み込んだJSON内容をRubyのハッシュや配列に変換
    users = JSON.parse(file)

    # 変換された各ユーザーデータに対して繰り返し処理を実行
    users.each do |user_data|
      # 各ユーザーデータを元に新しい AppUser レコードを作成
      AppUser.create!(user_data)
    end
  end
end
