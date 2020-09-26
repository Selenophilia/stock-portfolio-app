class StockController < ApplicationController
    before_action :load_api


    def index
        @quote = @client.quote('MSFT')

     
    end 


    private
    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: 'Tpk_21780fe8aa454bbe84a3a7d693b51372',
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
    
    end

end
