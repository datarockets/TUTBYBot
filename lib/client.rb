require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../config/config'
require_relative 'api'
require 'yaml'

include API

class Client
  def initialize
    @messages = YAML::load(IO.read(messages_path))

    Telegram::Bot::Client.run(Config::TOKEN) do |bot|

      @bot = bot

      @bot.enable_botan!(Config::BOTAN_TOKEN)

      @bot.listen do |message|

        id = message.chat.id

        case message.text
          when '/start'
            track_event('Новый пользователь', id)
            send_response(id, @messages['start_using'])

          when '/help'
            track_event('Новый пользователь', id)
            send_response(id, @messages['help'])

          when '/author'
            track_event('Автор', id)
            send_response(id, @messages['author'])

          when '/search'
            track_event('Попытка поиска', id)
            send_response(id, @messages['try_search'])

          when /search/i
            split = message.text.split(" ")
            unless split[1].nil?
              query = split[1]
              search_for_news(id, query)
          	end

          when '/top'
            last_news_getter(id, "Топ-5 новостей", "top")

          when '/now'
            last_news_getter(id, "Последние новости", "now")

          when '/politics'
            news_category_getter(id, "Политика", "10", 86)

          when '/economics'
            news_category_getter(id, "Экономика", "9", 39)

          when '/finance'
            news_category_getter(id, "Финансы", "310", 41)

          when '/society'
            news_category_getter(id, "Общество", "11", 43)

          when '/world'
            news_category_getter(id, "Мировые новости", "3", 49)

          when '/sports'
            news_category_getter(id, "Спорт", "6", 53)

          when '/culture'
            news_category_getter(id, "Культура", "5", 57)

          when '/42'
            news_category_getter(id, "42", "15", 65)

          when '/auto'
            news_category_getter(id, "Автоновости", "7", 69)

          when '/accidents'
            news_category_getter(id, "Происшествия", "103", 73)

          when '/property'
            news_category_getter(id, "Недвижимость", "486", 79)

          when '/agenda'
            news_category_getter(id, "Афиша", "491", 98)

          when '/kurs'
            currencies_getter(id, "Курсы валют")
        end
      end
    end
  end

  private
    def send_response(id, response)
      @bot.api.sendMessage(chat_id: id, text: response)
    end

    def track_event(id, event)
      @bot.track(event, id, type_of_chat: id)
    end

    def news_category_getter(chat, title, category, id)
      track_event(chat, title)
      response = news_category_handler(category, id)
      news = response['result'].each do |result|
        items = result['items']
        news_sender(items, chat)
      end
    end

    def search_for_news(chat, query)
      track_event(chat, "Поиск новостей по фразе #{query}")

      response = search_news(query)
      news = response['result']['items']

      news_ids = (0..4).inject([]) { |ids, index| ids << news[index]['id'] }
      news_response = get_news(news_ids)

      new_response = news_response['result']['items']
      news_sender(new_response, chat)
    end

    def last_news_getter(chat_id, title, category)
      track_event(chat_id, title)
      response = main_handler(category)
      news = response['result']['items']
      news_sender(news, chat_id)
    end

    def currencies_getter(chat_id, title)
      track_event(chat_id, title)
      response = finance_request
      currencies = response['exchangeRates']
      currencies_sender(currencies, chat_id)
    end

    def news_sender(news, id)
      news[0..4].each do |item|
        send_response(id, "#{item['title']} \n #{item['shortUrl']}")
      end
    end

    def currencies_sender(currencies, id)
      currencies[0..3].each do |currency|
        send_response(id, "#{currency['currencyCode']} - #{currency['nb']}")
      end
    end

    def messages_path
      "config/messages.yml"
    end

end
