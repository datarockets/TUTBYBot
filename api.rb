require 'net/http'
require 'json'

class API

  NEWS_SERVER = 'news.tut.by'
  FINANCE_SERVER = 'finance.tut.by'

  NEWS_METHOD = '/exports/android_v2.php'
  FINANCE_METHOD = '/export/info_for_pda.php'

  PORT = '80'

  CONTENT_HEADER = {'Content-Type' => 'application/json'}

  def news_category_handler(category_id, id)
    json = {
              "jsonrpc" => "2.0",
              "method" => "/tutby/categories/updates_list",
              "params" => {
                "items" => [{
                    "categoryId" => category_id, "updated" => Time.now.to_i.to_s
                  }]
              }, "id" => id
            }.to_json
    return apiRequest(json)
  end

  def main_handler(type)
    case type
      when 'top'
        json = { "jsonrpc" => "2.0", "method" => "/tutby/top5", "params" => { "limit" => 5 }, "id" => 6 }.to_json
      when 'now'
        json = { "jsonrpc" => "2.0", "method" => "/tutby/news/popular", "params" => { "count" => "5" }, "id" => 4 }.to_json
    end
    return apiRequest(json)
  end

  def search_news(query)
    json = {
      	"jsonrpc" => "2.0",
      	"method" => "/tutby/news/search",
      	"params" => {
      		"categories" => ["50", "99011", "10", "9", "310", "11", "3", "6", "5", "336", "15", "7", "103", "16", "486", "491", "51"],
      		"text" => query
      	}, "id"=> "15"
    }.to_json
    return apiRequest(json)
  end

  def get_news(news_array)
    json = {
    	"jsonrpc" => "2.0",
    	"method" => "/tutby/news/data",
    	"params" => {
    		"ids" => news_array
    	},
    	"id" => "16"
    }.to_json
    return apiRequest(json)
  end

  def apiRequest(json)
    request = Net::HTTP::Post.new(NEWS_METHOD, initiheader = CONTENT_HEADER)
    request.body = json
    response = Net::HTTP.new(NEWS_SERVER, PORT).start {|http| http.request(request)}
    return JSON.parse(response.body)
  end

  def finance_request
    request = Net::HTTP::Post.new(FINANCE_METHOD)
    request.set_form_data(
      'auth_key' => 'hiLlo77mAul94oINk19ANile',
      'action' => 'get_best_rates',
      'params' => {"country" => "belarus","api-version" => 2,"locale" => "ru","ts" => "0","city_id" => 15800 }
    )
    response = Net::HTTP.new(FINANCE_SERVER, PORT).start {|http| http.request(request)}
    return JSON.parse(response.body)
  end

end
