class Actions::CurrenciesAction < Actions::BaseAction
  @@count_per_msg = 4

  def initialize(params)
    super params
  end

  def main_currencies
    track_event

    currencies = finance_request['exchangeRates']

    send currencies
  end

  private

    def send(currencies)
      currencies[0...@@count_per_msg].each do |currency|
        send_response info_about(currency)
      end
    end

    def info_about(currency)
      "#{ currency['currencyCode'] } - #{ currency['nb'] }"
    end

end
