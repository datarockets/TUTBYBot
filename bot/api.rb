require 'net/http'
require 'json'
require 'pry'
require_relative '../config/server'

module Bot
  module API
    def news_category_handler(category_id, id)
      params = {
        jsonrpc: "2.0",
        method: "/tutby/categories/updates_list",
        id: id,
        params: {
          items: [{
            categoryId: category_id,
            updated: Time.now
          }]
        }
      }

      news_request_with params
    end

    def main_handler(type)
      params = case type
        when 'top'
          {
            jsonrpc: "2.0",
            method: "/tutby/top5",
            id: 6,
            params: {
              limit: 5
            }
          }
        when 'now'
          {
            jsonrpc: "2.0",
            method: "/tutby/news/popular",
            id: 4,
            params: {
              count: "5"
            }
          }
      end

      news_request_with params
    end

    def search_news(query)
      categories = %w(50 99011 10 9 310 11 3 6 5 336 15 7 103 16 486 491 51)

      params = {
        jsonrpc: "2.0",
        method: "/tutby/news/search",
        id: "15",
        params: {
          categories: categories,
          text: query
        }
      }

      news_request_with params
    end

    def get_news(news_array)
      params = {
        jsonrpc: "2.0",
        method: "/tutby/news/data",
        id: "16",
        params: {
          ids: news_array
        }
      }

      news_request_with params
    end

    def finance_request
      params = {
        auth_key: 'hiLlo77mAul94oINk19ANile',
        action: 'get_best_rates',
        params: {
          country: "belarus",
          locale: "ru",
          ts: "0",
          city_id: "15800"
        }
      }

      finance_request_with params
    end

    private

      def finance_request_with(params)
        api_request(
          server: Config::Server::FINANCE_SERVER,
          method: Config::Server::FINANCE_METHOD,
          params: params,
          type: :finance
        )
      end

      def news_request_with(params)
        api_request(
          server: Config::Server::NEWS_SERVER,
          method: Config::Server::NEWS_METHOD,
          params: params,
          type: :news
        )
      end

      def api_request(server:, method:, params:, type:)
        request = Net::HTTP::Post.new method

        if type == :news
          request.body = params.to_json
        else
          request.set_form_data params
        end

        request_to_server = Net::HTTP.new server
        response = request_to_server.start { |http| http.request(request) }

        JSON.parse(response.body)
      end

  end
end
