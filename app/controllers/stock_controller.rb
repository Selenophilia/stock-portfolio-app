class StockController < ApplicationController
    before_action :load_api, only: [:index,:show]


    def index
        @user        = current_user
        @stocks      = User.find(current_user.id).stocks.uniq ||=nil
        @stock_data  = Hash.new
        @stocks.each do |stock|
            quantity = 0
            
            total_price = 0

            quote = @client.quote(stock.symbol)

            price = quote.latest_price
            change_percent = quote.change_percent_s

            @user.transactions.where(stock_id: stock.id).each do |st|
                quantity = quantity + st.quantity
            end

            @user.transactions.where(stock_id: stock.id).each do |st|
                total_price = total_price + st.purchase_price
            end

            @stock_data[stock.symbol] = [quantity, price, change_percent, total_price]
        end
        @transaction = Transaction.new(user_id: current_user.id)
        @transaction.build_stock   
    end 

    def create
    end 

    def show
        
        @most_active = @client.stock_market_list(:mostactive)
    end       


    private

    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: 'Tpk_21780fe8aa454bbe84a3a7d693b51372',
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
    end

    def stock_params
        params.require(:stock).permit(:symbol)
    end

end
