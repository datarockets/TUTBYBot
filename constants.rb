class Constants

	# Here it is our tokens
	TOKEN = nil
	BOTAN_TOKEN = nil
	
	# Pretty simple JSON-payload from the official API
	TOP_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/top5", "params" => { "limit" => 5 }, "id" => 6 }.to_json
	NOW_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/news/popular", "params" => { "count" => "5" }, "id" => 4 }.to_json
	
	# But there are more complicated
	POLITICS_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "10", "updated" => Time.now.to_i.to_s }] }, "id" => 86 }.to_json
	ECONOMICS_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "9", "updated" => Time.now.to_i.to_s }] }, "id" => 39 }.to_json
	FINANCE_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "310", "updated" => Time.now.to_i.to_s }] }, "id" => 41 }.to_json
	SOCIETY_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{"categoryId" => "11", "updated" => Time.now.to_i.to_s }] }, "id" => 43 }.to_json
	WORLD_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "3", "updated" => Time.now.to_i.to_s }] }, "id" => 49 }.to_json
	SPORTS_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "6", "updated" => Time.now.to_i.to_s }] }, "id" => 53 }.to_json
	CULTURE_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "5", "updated" => Time.now.to_i.to_s }] }, "id" => 57 }.to_json
	IT_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "15", "updated" => Time.now.to_i.to_s }] }, "id" => 65 }.to_json
	AUTO_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "7", "updated" => Time.now.to_i.to_s }] }, "id" => 69 }.to_json
	ACCIDENTS_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "103", "updated" => Time.now.to_i.to_s }] }, "id" => 73 }.to_json
	PROPERTY_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list",
	"params" => { "items" => [{ "categoryId" => "486", "updated" => Time.now.to_i.to_s }] }, "id" => 79 }.to_json
	AGENDA_PAYLOAD = { "jsonrpc" => "2.0", "method" => "/tutby/categories/updates_list", 
	"params" => { "items" => [{ "categoryId" => "491", "updated" => Time.now.to_i.to_s }], }, "id" => 98 }.to_json



	START_USING = 'Добро пожаловать в неофициальный бот лучшего интернет-портала страны TUT.BY! Чтобы узнать список команд, наберите /help'
	ALREADY_SUBSCRIBED = 'Вы уже подписаны на рассылку. Спасибо!'
	THANKFUL_SUBSCRIBER = 'Спасибо за подписку на нашу рассылку. Ждите новостей каждый вечер в 19:00 по Минску.'
	USER_UNSUBSCRIBED = 'Нам жаль, что вы решили отписаться от наших новостей. Надеемся, что вы передумаете.'
	AUTHOR = 'Меня создал @Chyrta. Вы можете обращаться к нему с критикой и предложениями.'
	HELP = 'Бот TUT.BY отдает по 5 новостей по запросу:
					/top — главные новости
					/now — новости, которые сейчас читают
					/politics — новости политики
					/economics — новости экономики и бизнеса
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