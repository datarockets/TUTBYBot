require_relative 'api'
require 'yaml'
require 'pry'

class Bot::Action
  include Bot::API

  def initialize(bot:, user_message:)
    @bot = bot
    @user_message = user_message
    @id = @user_message.chat.id
    @messages = YAML::load(IO.read(messages_path))
  end

  def run
    case @user_message.text
      when '/start'
        track_event('Новый пользователь')
        send_response(@messages['start_using'])

      when '/help'
        track_event('Новый пользователь')
        send_response(@messages['help'])

      when '/author'
        track_event('Автор')
        send_response(@messages['author'])

      when /search/i
        query = @user_message.text.split(' ')[1..-1].join(' ')
        if query.empty?
          track_event('Попытка поиска')
          send_response(@messages['try_search'])
        else
          search_for_news(query)
        end

      when '/top'
        last_news_getter("Топ-5 новостей", "top")

      when '/now'
        last_news_getter("Последние новости", "now")

      when '/politics'
        news_category_getter("Политика", "10", 86)

      when '/economics'
        news_category_getter("Экономика", "9", 39)

      when '/finance'
        news_category_getter("Финансы", "310", 41)

      when '/society'
        news_category_getter("Общество", "11", 43)

      when '/world'
        news_category_getter("Мировые новости", "3", 49)

      when '/sports'
        news_category_getter("Спорт", "6", 53)

      when '/culture'
        news_category_getter("Культура", "5", 57)

      when '/42'
        news_category_getter("42", "15", 65)

      when '/auto'
        news_category_getter("Автоновости", "7", 69)

      when '/accidents'
        news_category_getter("Происшествия", "103", 73)

      when '/property'
        news_category_getter("Недвижимость", "486", 79)

      when '/agenda'
        news_category_getter("Афиша", "491", 98)

      when '/kurs'
        currencies_getter("Курсы валют")
    end
  end

  private

    def send_response(response)
      @bot.api.sendMessage(chat_id: @id, text: response)
    end

    def track_event(event)
      @bot.track(event, @id, type_of_chat: @id)
    end

    def news_category_getter(event, category, category_id)
      track_event(event)
      response = news_category_handler(category, category_id)
      news = response['result'].each do |result|
        items = result['items']
        news_sender(items)
      end
    end

    # TODO make it to looks fuckable
    def search_for_news(query)
      track_event("Поиск новостей по фразе #{query}")

      response = search_news(query)
      news = response['result']['items']

      return send_response('Новостей не найдено') if news.count == 0

      news_count = (1..3) === news.count ? news.count : 4

      news_ids = (0..news_count).inject([]) do |ids, index|
        ids << news[index]['id']
      end

      news_response = get_news(news_ids)

      new_response = news_response['result']['items']
      news_sender(new_response)
    end

    def last_news_getter(event, category)
      track_event(event)
      response = main_handler(category)
      news = response['result']['items']
      news_sender(news)
    end

    def currencies_getter(event)
      track_event(event)
      response = finance_request
      currencies = response['exchangeRates']
      currencies_sender(currencies)
    end

    def news_sender(news)
      news[0..4].each do |item|
        send_response("#{item['title']} \n #{item['shortUrl']}")
      end
    end

    def currencies_sender(currencies)
      currencies[0..3].each do |currency|
        send_response("#{currency['currencyCode']} - #{currency['nb']}")
      end
    end

    def messages_path
      "config/messages.yml"
    end

end
