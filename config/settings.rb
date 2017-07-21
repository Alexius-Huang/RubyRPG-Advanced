# frozen_string_literal: true

module RubyRPG
  module Settings
    # Environment global params which can switch in different state of the
    # project, which are 'development', 'testing' and 'production'
    ENV = 'development'.freeze

    ROOT = Dir.pwd

    # Gems to require in different environment, you can add more different
    # case of the environment to load the corresponding gems
    Gems = {
      %w[development production testing] => %w[
        active_support
        colorize
        erb
        json
        ostruct
        yaml
      ],
      %w[development testing] => %w[
        byebug
        rspec
      ],
      %w[testing] => %w[]
    }.freeze

    # Include the file path to load files in order
    Files = %w[
      /config/extension.rb
      /application/objects/universe.rb
      /application/objects/matrix.rb
      /application/objects/location.rb
      /application/objects/character.rb
      /application/objects/monster.rb
      /application/objects/substance.rb
      /application/objects/item.rb
      /application/controllers/application.rb
      /application/controllers/base.rb
      /application/controllers/main.rb
      /application/controllers/location.rb
      /config/constant.rb
      /config/callback.rb
    ].freeze

    # Load callback to enable "before_action" and "after_action" mechanism
    Callback = true
  end
end
