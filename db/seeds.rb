# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# サンプルユーザー
application_user = ApplicationUser.create!(
  user_id: 'user123',
  nickname: 'Sample User',
  email: 'user@example.com',
  password: 'password123', 
  account_type: 'individual',
  role: 'user' # 必要に応じてロールを指定
)

# サンプルモデルコース
5.times do |i|
  ModelCourse.create!(
    title: "モデルコース#{i + 1}",
    description: "これはサンプルモデルコースです#{i + 1}",
    application_user: application_user # 関連付け
  )
end
