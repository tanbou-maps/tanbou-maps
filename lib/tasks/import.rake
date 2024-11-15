# lib/tasks/import.rake
namespace :db do
  desc 'Import users from JSON file'
  task import_users: :environment do
    file_path = File.join(Rails.root, 'path', 'to', 'your', 'users.json')
    file = File.read(file_path)
    users = JSON.parse(file)

    users.each do |user_data|
      AppUser.create!(user_data)
    end
  end
end
