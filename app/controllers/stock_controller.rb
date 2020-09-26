class StockController < ApplicationController
    before_action :load_api


    def index
        quote = @client.quote('MSFT')

       @latest_price =  quote.latest_price # 90.165
      @get_change =  quote.change # 0.375
       @get_percent= quote.change_percent # 0.00418
       @get_change_percent= quote.change_percent_s # '+0.42%'
    end 


    private
    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: 'Tpk_21780fe8aa454bbe84a3a7d693b51372',
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
    
    end

end
