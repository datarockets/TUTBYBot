require_relative 'api'
require 'yaml'
require 'pry'

class Bot::Action
  include Bot::API

  def initialize(bot:, user_message:)
    @bot = bot
    @user_message = user_message
    @id = @user_message.chat.id

    @news_count_per_msg = 5
    @currencies_count_per_msg = 4

    @messages = load_yaml_file(messages_path)
    @events = load_yaml_file(events_path)
  end

  def run
    case @user_message.text
      when '/start' then basic_response('start')
      when '/help' then basic_response('help')
      when '/author' then basic_response('author')

      when /search/i
        query = @message.split(' ')[1..-1].join(' ')
        query.empty? ? basic_response('try_search') : search_for_news(query)

      when '/top'
        last_news_getter(@events['top'], "top")

      when '/now'
        last_news_getter(@events['now'], "now")

      when '/politics'
        news_category_getter(@events['politics'], "10", 86)

      when '/economics'
        news_category_getter(@events['economics'], "9", 39)

      when '/finance'
        news_category_getter(@events['finance'], "310", 41)

      when '/society'
        news_category_getter(@events['society'], "11", 43)

      when '/world'
        news_category_getter(@events['world'], "3", 49)

      when '/sports'
        news_category_getter(@events['sports'], "6", 53)

      when '/culture'
        news_category_getter(@events['culture'], "5", 57)

      when '/42'
        news_category_getter(@events['42'], "15", 65)

      when '/auto'
        news_category_getter(@events['auto'], "7", 69)

      when '/accidents'
        news_category_getter(@events['accidents'], "103", 73)

      when '/property'
        news_category_getter(@events['property'], "486", 79)

      when '/agenda'
        news_category_getter(@events['agenda'], "491", 98)

      when '/kurs'
        currencies_getter(@events['kurs'])

      else basic_response('help')
    end
  end

  private

    def basic_response(event)
      track_event @events[event]
      send_response @messages[event]
    end

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
      track_event("#{@events['search_news']} #{query}")

      response = search_news(query)
      news = response['result']['items']

      return basic_response('no_news_found') if news.count.zero?

      news_count = (1..3) === news.count ? news.count : @news_count_per_msg

      news_ids = (0..news_count - 1).inject([]) do |ids, index|
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
      news[0..@news_count_per_msg - 1].each do |item|
        send_response("#{item['title']} \n #{item['shortUrl']}")
      end
    end

    def currencies_sender(currencies)
      currencies[0..@currencies_count_per_msg - 1].each do |currency|
        send_response("#{currency['currencyCode']} - #{currency['nb']}")
      end
    end

    def load_yaml_file(file_path)
      YAML::load(IO.read(file_path))
    end

    def messages_path
      "config/messages.yml"
    end

    def events_path
      "config/events.yml"
    end

end
