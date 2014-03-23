require 'mechanize'
require 'json'

module BitcoinValue
  class << self
    
    VERSION = '0.0.10'
    
    API_URL = 'https://api.bitcoinaverage.com/ticker'
    VALID_FIATS = [
      :AUD, :BRL, :CAD, :CHF, :CNY, :EUR, :GBP, :HKD, :ILS, :JPY,
      :NOK, :NZD, :PLN, :RUB, :SEK, :SGD, :TRY, :USD, :ZAR
    ]
    
    def method_missing(meth, *args, &block)
      currency = meth.upcase.to_sym
      raise ArgumentError, "Cannot fetch data for #{currency}, as it is not offered by the API!" if !VALID_FIATS.include?(currency)
      JSON.parse(Mechanize.new.get("#{API_URL}/#{currency}").body)['24h_avg']
    end
    
  end
end