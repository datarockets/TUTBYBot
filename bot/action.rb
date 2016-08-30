require_relative 'api'
require 'yaml'
require 'pry'

class Bot::Action
  include Bot::API

  def initialize(bot:, user_message:)
    @bot = bot
    @user_text = user_message.text
    @id = user_message.chat.id

    @news_count_per_msg = 5
    @currencies_count_per_msg = 4

    @messages = load_yaml_file(messages_path)
    @events = load_yaml_file(events_path)
    @categories = load_yaml_file(categories_path)
  end

  def run
    case @user_text
      when '/start', '/help', '/author'
        basic_response clear_user_text

      when /search/i
        search_news_getter

      when '/top', '/now'
        last_news_getter clear_user_text

      when '/politics', '/economics', '/finance', '/society', '/world', '/sports',
           '/culture', '/42', '/auto', '/accidents', '/property', '/agenda'
        news_category_getter clear_user_text

      when '/kurs'
        currencies_getter clear_user_text

      else
        basic_response 'help'
    end
  end

  private

    def clear_user_text
      @user_text[1..-1]
    end

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

    def news_category_getter(category)
      track_event(@events[category])

      info = @categories[category]

      response = news_category_handler(info['name'], info['id'])
      response['result'].each { |result| news_sender(result['items']) }
    end

    def search_news_getter
      query = @user_text.split(' ')[1..-1].join(' ')
      query.empty? ? basic_response('try_search') : search_for_news(query)
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

    def last_news_getter(category)
      track_event(@events[category])
      response = main_handler(category)
      news = response['result']['items']
      news_sender(news)
    end

    def currencies_getter(event)
      track_event(@events[event])
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

    def categories_path
      "config/categories.yml"
    end

end
