require 'require_all'
require_all 'services'

class Actions::CurrenciesAction < Actions::BaseAction
  @@count_per_msg = 4

  def main_currencies
    track_event

    save_user_request

    currencies = finance_request['exchangeRates']

    send currencies
  end

  private

    def save_user_request
      Chat::Request.create(chat_id: @id, type: :currencies)
    end

    def send(currencies)
      currencies[0...@@count_per_msg].each do |currency|
        send_response info_about(currency)
      end
    end

    def info_about(currency)
      "#{ currency['currencyCode'] } - #{ currency['nb'] }"
    end

end
