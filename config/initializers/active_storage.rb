Rails.application.config.to_prepare do
  ActiveStorage::Current.url_options = {
    host: 'localhost',
    port: 3000,
    protocol: 'http'
  }

  # フォールバック設定も追加
  Rails.application.routes.default_url_options[:host] = 'localhost'
  Rails.application.routes.default_url_options[:port] = 3000
end
