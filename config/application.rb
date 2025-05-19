require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BooksApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # デフォルト言語を設定
    config.i18n.default_locale = :ja

    # I18nライブラリに訳文の探索場所を指示する
    I18n.load_path += Dir[Rails.root.join("config", "locale", "*.{yml}")]

    # ロケールを:en以外に変更する（一時的に）
    config.i18n.default_locale = :en

    # アプリケーションでの利用を許可するロケールのリストを渡す
    I18n.available_locales = [:en, :ja]
  end
end
