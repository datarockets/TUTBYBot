require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../config/config'
require_relative 'api'
require 'yaml'

include API

# Passing bot, chat id and response itself
def sendResponse(bot, id, response)
  bot.api.sendMessage(chat_id: id, text: response)
end

# Passing bot, chat id and event title
def trackEvent(bot, id, event)
  bot.track(event, id, type_of_chat: id)
end

# Passing bot, chat id, event title, news category id and special id
def newsCategoryGetter(bot, chat, title, category, id)
  trackEvent(bot, chat, title)
  json = news_category_handler(category, id)
  news = json['result'].each do |result|
    items = result['items']
    newsSender(items, bot, chat)
  end
end

# Pass a query to API
def search_news(bot, chat, query)
  trackEvent(bot, chat, "Поиск новостей по фразе #{query}")
  response = search_news(query)
  news_ids = []
  news = response['result']['items']
  news[0..4].each do |item|
    news_ids.push(item['id'])
  end
  news_json = get_news(news_ids)
  new_json = news_json['result']['items']
  newsSender(new_json, bot, chat)
end

# Passing bot, chat id, event title, news category id
def lastNewsGetter(bot, chat_id, title, category)
  trackEvent(bot, chat_id, title)
  json = main_handler(category)
  news = json['result']['items']
  newsSender(news, bot, chat_id)
end

# Passing bot, chat and event title
def currenciesGetter(bot, chat_id, title)
  trackEvent(bot, chat_id, title)
  json = finance_request
  currencies = json['exchangeRates']
  currenciesSender(currencies, bot, chat_id)
end

# Passing array from 5 hashes, bot and chat id
def newsSender(news, bot, id)
  news[0..4].each do |item|
    sendResponse(bot, id, "#{item['title']} \n #{item['shortUrl']}")
  end
end

def currenciesSender(currencies, bot, id)
  currencies[0..3].each do |currency|
    sendResponse(bot, id, "#{currency['currencyCode']} - #{currency['nb']}")
  end
end

class Client
  def initialize
    
    messages = YAML::load(IO.read(messages_path))

    Telegram::Bot::Client.run(Config::TOKEN) do |bot|

      # Enable Botan for tracking user events
      bot.enable_botan!(Config::BOTAN_TOKEN)

      # Listening to the user's commands
      bot.listen do |message|

        id = message.chat.id

        case message.text
          # User starts using
          when '/start'
            trackEvent(bot, 'Новый пользователь', id)
            sendResponse(bot, id, messages['start_using'])

          when '/help'
            trackEvent(bot, 'Новый пользователь', id)
            sendResponse(bot, id, messages['help'])

          when '/author'
            trackEvent(bot, 'Автор', id)
            sendResponse(bot, id, messages['author'])

          # A response for empty query
          when '/search'
            trackEvent(bot, 'Попытка поиска', id)
            sendResponse(bot, id, messages['try_search'])

          # User wants to search for some news
          when /search/i
            split = message.text.split(" ")
            unless split[1].nil?
              query = split[1]
              search_news(bot, id, query)
          	end

          # User wants to know the TOP5 of news
          when '/top'
            lastNewsGetter(bot, id, "Топ-5 новостей", "top")

          # User wants to know the latest news
          when '/now'
            lastNewsGetter(bot, id, "Последние новости", "now")

          # Politics
          when '/politics'
            newsCategoryGetter(bot, id, "Политика", "10", 86)

          # Economics
          when '/economics'
            newsCategoryGetter(bot, id, "Экономика", "9", 39)

          # Financial news
          when '/finance'
            newsCategoryGetter(bot, id, "Финансы", "310", 41)

          # Society
          when '/society'
            newsCategoryGetter(bot, id, "Общество", "11", 43)

          # World news
          when '/world'
            newsCategoryGetter(bot, id, "Мировые новости", "3", 49)

          # Sports
          when '/sports'
            newsCategoryGetter(bot, id, "Спорт", "6", 53)

          # Culture
          when '/culture'
            newsCategoryGetter(bot, id, "Культура", "5", 57)

          # IT-news
          when '/42'
            newsCategoryGetter(bot, id, "42", "15", 65)

          # Automobile news
          when '/auto'
            newsCategoryGetter(bot, id, "Автоновости", "7", 69)

          # Society
          when '/accidents'
            newsCategoryGetter(bot, id, "Происшествия", "103", 73)

          # Propery
          when '/property'
            newsCategoryGetter(bot, id, "Недвижимость", "486", 79)

          # User wants to know agenda
          when '/agenda'
            newsCategoryGetter(bot, id, "Афиша", "491", 98)

          # User gets currencies
          when '/kurs'
            currenciesGetter(bot, id, "Курсы валют")

        end
      end
    end
  end
  
  private 

    def messages_path
      "config/messages.yml"
    end

end
