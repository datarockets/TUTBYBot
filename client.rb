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
				bot.track('Новый пользователь', message.chat.id, type_of_chat: message.chat.id)		
				bot.api.sendMessage(chat_id: message.chat.id, text: Constants::START_USING)
			
			when '/help'
				bot.track('Помощь', message.chat.id, type_of_chat: message.chat.id)
				bot.api.sendMessage(chat_id: message.chat.id, text: Constants::HELP)

			when '/author'
				bot.track('Автор', message.chat.id, type_of_chat: message.chat.id)
				bot.api.sendMessage(chat_id: message.chat.id, text: Constants::AUTHOR)

			# User wants to know the TOP5 of news
			when '/top'
				bot.track('Топ-5 новостей', message.chat.id, type_of_chat: message.chat.id)
				
				
				news_json = api.request(Constants::TOP_PAYLOAD)
				news = news_json['result']['items']
				news.each do |item|
					bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
				end

			# User wants to know the latest news
			when '/now'
				bot.track('Последние новости', message.chat.id, type_of_chat: message.chat.id)

				# Getting the news-json and hash it
				news_json = api.request(Constants::NOW_PAYLOAD)
				news = news_json['result']['items']
				
				# Iterate and send to the user
				news.each do |item|
					bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
				end

			# Politics
			when '/politics'
				bot.track('Политика', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::POLITICS_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Economics
			when '/economics'
				bot.track('Экономика и бизнес', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::ECONOMICS_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Financial news
			when '/finance'
				bot.track('Финансы', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::FINANCE_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Society
			when '/society'
				bot.track('Общество', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::SOCIETY_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# World news
			when '/world'
				bot.track('Мировые новости', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::WORLD_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Sports
			when '/sports'
				bot.track('Спорт', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::SPORTS_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Culture
			when '/culture'
				bot.track('Культура', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::CULTURE_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# IT-news
			when '/42'
				bot.track('42', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::IT_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Automobile news
			when '/auto'
				bot.track('Автоновости', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::AUTO_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Society
			when '/accidents'
				bot.track('Происшествия', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::ACCIDENTS_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# Propery
			when '/property'
				bot.track('Недвижимость', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::PROPERTY_PAYLOAD)
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# User wants to know agenda
			when '/agenda'
				bot.track('Культура', message.chat.id, type_of_chat: message.chat.id)

				news_json = api.request(Constants::AGENDA_PAYLOAD)	
				news = news_json['result'].each do |result|
					items = result['items']
					items[0..4].each do |item|
						bot.api.sendMessage(chat_id: message.chat.id, text: item['title'] + "\n" + "\n" + item['shortUrl'])
					end
				end

			# User gets currencies
			when '/kurs'
				bot.track('Курс валют', message.chat.id, type_of_chat: message.chat.id)

				kurs_json = api.finance_request
				currencies = kurs_json['exchangeRates']

				bot.api.sendMessage(chat_id: message.chat.id, text: currencies[0]['currencyCode'] + ' - ' + currencies[0]['nb'] + "\n" + currencies[1]['currencyCode'] + ' - ' + currencies[1]['nb'] + "\n" + currencies[2]['currencyCode'] + ' - ' + currencies[2]['nb'] )

		end
	end
end
