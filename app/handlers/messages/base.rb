# frozen_string_literal: true

module Handlers
  module Messages
    class Base < Handlers::Base
      attr_reader :bot

      def initialize(bot:)
        @bot = bot
      end

      def call(message)
        if message.text[0] == '/'
          # if this message starts with a slash ("/"), like a command
          Handlers::Messages::Common::Base.new(bot: bot, tg_user: message.from).(message.text)
        else
          # if this message is just a simple text
          Handlers::Messages::Text::Base.new(bot: bot, tg_user: message.from).(message.text)
        end
      end
    end
  end
end
