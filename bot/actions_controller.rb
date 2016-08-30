require 'require_all'
require_all 'bot/actions'

class ActionsController
  def initialize(bot:, user_message:)
    @bot = bot
    @user_text = user_message.text
    @id = user_message.chat.id
  end

  def select_action
    case @user_text
      when '/start', '/help', '/author'
        base_action.basic_response

      when /search/i
        news_action.search_news

      when '/top', '/now'
        news_action.last_news

      when '/politics', '/economics', '/finance', '/society', '/world', '/sports',
           '/culture', '/42', '/auto', '/accidents', '/property', '/agenda'
        news_action.category_news

      when '/kurs'
        currencies_action.main_currencies

    end
  end

  private

    def base_action
      Actions::BaseAction.new(params)
    end

    def currencies_action
      Actions::CurrenciesAction.new(params)
    end

    def news_action
      Actions::NewsAction.new(params)
    end

    def params
      {
        bot: @bot,
        id: @id,
        action: action
      }
    end

    def action
      @user_text[1..-1]
    end

end
