require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Thinknetica
  class Application < Rails::Application

    config.load_defaults 6.1

    # указываем какие спеки нам нужно сгенерировать
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: true
    end
    # config.factory_bot.definition_file_paths = ["spec/factories"]
  end
end
