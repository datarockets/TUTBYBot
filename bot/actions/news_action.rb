class Actions::NewsAction < Actions::BaseAction
  @@count_per_msg = 5

  def initialize(params)
    super params
  end

  def last_news
    Chat::Request.create(chat_id: @id, type: :top)

    search_action_wrapper do
      main_handler @action
    end
  end

  def category_news
    Chat::Request.create(chat_id: @id, type: :news, payload: @action)

    search_action_wrapper do
      info = categories[@action]
      news_category_handler(info['name'], info['id'])
    end
  end

  def search_news
    query = @action.split(' ')[1..-1].join(' ')

    Chat::Request.create(chat_id: @id, type: :search, payload: query)

    query.empty? ? basic_response('try_search') : search_for_news(query)
  end

  private

    def search_for_news(query)
      event = "#{ events['search_news'] } #{ query }"

      search_action_wrapper event do
        news = get_news_for query

        return basic_response('no_news_found') if news.count.zero?

        news_ids = find_ids_of news
        get_news news_ids
      end
    end

    def search_action_wrapper(event = nil, &block)
      track_event event

      response = yield(block)
      news = result_of response

      send news
    end

    def find_ids_of(news)
      news_count = (1..3).include?(news.count) ? news.count : @@count_per_msg

      (0...news_count).inject([]) { |ids, index| ids << news[index]['id'] }
    end

    def get_news_for(query)
      response = check_news query
      result_of response
    end

    def result_of(response)
      result = response['result']

      result.is_a?(Array) ? result.first['items'] : result['items']
    end

    def send(news)
      news[0...@@count_per_msg].each do |novelty|
        send_response info_about(novelty)
      end
    end

    def info_about(novelty)
      "#{ novelty['title'] } \n #{ novelty['shortUrl'] }"
    end

end
