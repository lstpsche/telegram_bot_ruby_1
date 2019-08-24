# frozen_string_literal: true

class Talker
  attr_reader :bot

  def initialize(bot:)
    @bot = bot
  end

  def send_message(text:, chat_id:, markup: nil)
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    bot.api.send_message(chat_id: chat_id, text: text, reply_markup: markup)
  end

  def get_message
    bot.listen { |message| return message }
  end

  def self.get_message(bot:)
    bot.listen { |message| return message }
  end

  def self.send_help_message(bot:, chat_id:)
    bot.api.send_message(chat_id: chat_id, text: I18n.t('common.help'))
  end

  def self.send_shorten_help_message(bot:, chat_id:)
    bot.api.send_message(chat_id: chat_id, text: I18n.t('common.shorten_help'))
  end
end
