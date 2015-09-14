require 'telegram/bot'
require 'telegram/bot/botan'
require './constants.rb'
require './api.rb'

# Obtained tokens from Telegram Botfather and Yandex.AppMetrika
token = Constants::TOKEN
botan_token = Constants::BOTAN_TOKEN

# Init API
api = API.new

Telegram::Bot::Client.run(token) do |bot|

	# Let Botan track user's requests
	bot.enable_botan!(botan_token)

	# Listening to the user's commands
	bot.listen do |message|
		case message.text

			# User starts using
			when '/start'
				bot.track('Новый пользователь бота', message.chat.id, type_of_chat: message.chat.id)		
				bot.api.sendMessage(chat_id: message.chat.id, text: Constants::START_USING)
			
			when '/help'
				bot.track('Пользователь запрашивает помощь', message.chat.id, type_of_chat: message.chat.id)
				bot.api.sendMessage(chat_id: message.chat.id, text: Constants::HELP)

			when '/author'
				bot.track('Пользователь узнает об авторе', message.chat.id, type_of_chat: message.chat.id)
				bot.api.sendMessage(chat_id: message.chat.id, text: Constants::AUTHOR)

			# User wants to know the latest news
			when '/now'
				bot.track('Пользователь получает последние новости', message.chat.id, type_of_chat: message.chat.id)

				# Getting the news-json and hash it
				news_json = api.request(Constants::NOW_PAYLOAD)
				news = news_json['result']['items']
				
				# Iterate and send to the user
				news.each do |item|
					bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
				end
			
			# User wants to know the TOP5 of news
			when '/top'
				bot.track('Пользователь получает Топ-5 последних новостей', message.chat.id, type_of_chat: message.chat.id)
				
				
				news_json = api.request(Constants::TOP_PAYLOAD)
				news = news_json['result']['items']
				news.each do |item|
					bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
				end

			when '/agenda'
				bot.track('Пользователь получает новости о культуре', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::AGENDA_PAYLOAD)	
				news = news_json['result'].each do |result|
					items = result['items']
					items.each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

		end
	end

end
