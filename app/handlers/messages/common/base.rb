# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      COMMAND_REGEX = /^\/(\w+)$/

      class Base < Handlers::Base
        attr_reader :bot, :tg_user

        def initialize(bot:, tg_user:)
          @bot = bot
          @tg_user = tg_user
        end

        def call(command)
          command = command.match(COMMAND_REGEX)[1]

          send(command)
        end

        def method_missing(method_name, *args, &block)
          no_method
        end

        def start
          binding.pry
          return false if User.find_by(tg_id: tg_user.id)

          ::Actions::Users::Registration.new(bot: bot, tg_user: tg_user).launch
        end

        def settings
          # if user is registered -- launch settings setup
          # else -- return false
        end

        def help
        end

        def no_method
        end
      end
    end
  end
end
