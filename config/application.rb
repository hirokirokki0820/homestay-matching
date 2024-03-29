require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HomestayMatching
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    # config.eager_load_paths << Rails.root.join("extras")
    # inputタグに 「field_with_errors」 を自動挿入しないようにする(エラー時のレイアウト崩れを防ぐため)
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    #ActiveStorage上書きしない
    config.active_storage.replace_on_assign_to_many = false
    config.active_storage.variant_processor = :mini_magick
  end
end
