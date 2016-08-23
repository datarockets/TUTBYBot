require 'net/http'
require 'json'
require_relative '../config/config'

module API
  def news_category_handler(category_id, id)
    json = {
      jsonrpc: "2.0",
      method: "/tutby/categories/updates_list",
      params: {
        items: [{
          categoryId: category_id,
          updated: Time.now.to_i.to_s
        }]
      }, id: id
    }.to_json

    apiRequest(json)
  end

  def main_handler(type)
    case type
      when 'top'
        json = {
          jsonrpc: "2.0",
          method: "/tutby/top5",
          id: 6,
          params: {
            limit: 5
          }
        }.to_json
      when 'now'
        json = {
          jsonrpc: "2.0",
          method: "/tutby/news/popular",
          id: 4,
          params: {
            count: "5"
          }
        }.to_json
    end

    apiRequest(json)
  end

  def search_news(query)
    categories = %w(50 99011 10 9 310 11 3 6 5 336 15 7 103 16 486 491 51)

    json = {
      jsonrpc: "2.0",
      method: "/tutby/news/search",
      i: "15",
      params: {
        categories: categories,
        text: query
      }
    }.to_json

    apiRequest(json)
  end

  def get_news(news_array)
    json = {
      jsonrpc: "2.0",
      method: "/tutby/news/data",
      id: "16",
      params: {
        ids: news_array
      }
    }.to_json

    apiRequest(json)
  end

  def finance_request
    request = Net::HTTP::Post.new(Config::FINANCE_METHOD)
    request.set_form_data(
      auth_key: 'hiLlo77mAul94oINk19ANile',
      action: 'get_best_rates',
      params: {
        country: "belarus",
        locale: "ru",
        ts: "0",
        city_id: 15800
      }
    )

    response = Net::HTTP.new(Config::FINANCE_SERVER, Config::PORT)
      .start {|http| http.request(request)}

    JSON.parse(response.body)
  end

  private

    def apiRequest(json)
      request = Net::HTTP::Post.new(Config::NEWS_METHOD, initiheader = { 'Content-Type' => 'application/json' })
      request.body = json
      response = Net::HTTP.new(Config::NEWS_SERVER, Config::PORT)
        .start {|http| http.request(request)}

      JSON.parse(response.body)
  end
end
