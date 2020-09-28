class StockController < ApplicationController
    before_action :load_api


    def index
        @user        = current_user
        @stocks      = User.find(current_user.id).stocks.uniq
        @stock_data  = Hash.new

        @stocks.each do |stock|
            quantity = 0
            
            total_price = 0

            quote = client.quote(stock.symbol)

            price = quote.latest_price
            change = quote.change
            change_percent = change.change_percent_s

            @user.transactions.where(stock_id: stock.id).each do |st|
                quantity = quantity + st.quantity
            end

            @user.transactions.where(stock_id: stock.id).each do |st|
                total_price = total + st.price
            end

            @stock_data[stock.symbol] = [quantity, price, change_percent, total_price]
        
        end
        


        # @quote       = @client.quote('IBM').latest_price   
        # @computation = @quote * 5    
        # @user.calc_total_balance(@computation)
    end 


    private

    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: 'Tpk_21780fe8aa454bbe84a3a7d693b51372',
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
    end

end
