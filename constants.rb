class Constants

	TOKEN = nil
	BOTAN_TOKEN = nil

	NOW_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/news/popular", "params" => { "count" => "5" }, "id" => 4 }.to_json
	TOP_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/top5", "params" => { "limit" => 5 }, "id" => 6 }.to_json
	AGENDA_PAYLOAD = {
					"jsonrpc" => "2.0",
					"method" => "/tutby/categories/updates_list",
					"params" => {
						"items" => [{
							"categoryId" => "491",
							"updated" => Time.now.to_i.to_s
				        }],
					},
					"id" => 98,
				}.to_json


	START_USING = 'Добро пожаловать в неофициальный бот лучшего интернет-портала страны TUT.BY! Чтобы узнать список команд, наберите /help'
	ALREADY_SUBSCRIBED = 'Вы уже подписаны на рассылку. Спасибо!'
	THANKFUL_SUBSCRIBER = 'Спасибо за подписку на нашу рассылку. Ждите новостей каждый вечер в 19:00 по Минску.'
	USER_UNSUBSCRIBED = 'Нам жаль, что вы решили отписаться от наших новостей. Надеемся, что вы передумаете.'
	AUTHOR = 'Меня создал @Chyrta. Вы можете обращаться к нему с критикой и предложениями.'
	HELP = 'Бот TUT.BY отдает по 5 новостей по запросу:
					/top — главные новости
					/search — поиск по новостям. Например, вы можете ввести слово «Короткевич», и мы покажем 5 последних новостей с упоминанием слова.
					/now — новости, которые сейчас читают
					/politics — новости политики
					/economics — новости экономики
					/finance — новости финансов
					/society — новости общества
					/world — мировые новости
					/sports — новости спорта
					/culture — новости культуры
					/42 — новости из мира технологий
					/auto — новости из автомира
					/accidents — происшествия
					/property — недвижимость
					/agenda — афиша
					/kurs — курс основных валют от НБРБ
					/author — информация об авторе бота'





end