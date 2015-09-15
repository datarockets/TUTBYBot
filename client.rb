require 'telegram/bot'
require 'telegram/bot/botan'
require_relative 'constants'
require_relative 'api'

# Obtained tokens from Telegram Botfather and Yandex.AppMetrika
token = Constants::TOKEN
botan_token = Constants::BOTAN_TOKEN


# METHODS FOR PARSING AND SENDING DATA BACK TO THE USER

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
  api = API.new
  json = api.news_category_handler(category, id)      
  news = json['result'].each do |result|
    items = result['items']
    newsSender(items, bot, chat)
  end
end

# Passing bot, chat id, event title, news category id
def lastNewsGetter(bot, chat_id, title, category)
  trackEvent(bot, chat_id, title)
  api = API.new
  json = api.main_handler(category)
  news = json['result']['items']
  newsSender(news, bot, chat_id)
end

# Passing bot, chat and event title
def currenciesGetter(bot, chat_id, title)
  trackEvent(bot, chat_id, title)
  api = API.new
  json = api.finance_request
  currencies = json['exchangeRates']
  currenciesSender(currencies, bot, chat_id) 
end

# Passing array from 5 hashes, bot and chat id 
def newsSender(news, bot, id)
  news[0..4].each do |item|
    sendResponse(bot, id, item['title'] + "\n\n" + item['shortUrl'])
  end
end

def currenciesSender(currencies, bot, id)
  currencies[0..3].each do |currency|
    sendResponse(bot, id, currency['currencyCode'] + ' - ' + currency['nb'])
  end
end

# BOT STARTS WORKING #

Telegram::Bot::Client.run(token) do |bot|

  # Let Botan track user's requests
  bot.enable_botan!(botan_token)
  
  # Listening to the user's commands
  bot.listen do |message|

    id = message.chat.id
    
    case message.text
      # User starts using
      when '/start'
        trackEvent(bot, 'Новый пользователь', id)   
        sendResponse(bot, id, Constants::START_USING)

      when '/help'
        trackEvent(bot, 'Помощь', id)
        sendResponse(bot, id, Constants::HELP)

      when '/author'
        trackEvent(bot, 'Автор', id)
        sendResponse(bot, id, Constants::AUTHOR)

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
