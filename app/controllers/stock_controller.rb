class StockController < ApplicationController
    before_action :load_api, only: [:index,:show]

    require 'net/http'
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
         uri = URI('https://sandbox.iexapis.com/stable/stock/market/list/mostactive?token=Tsk_abb3bfef5bac4820b058ea01006a8627&listLimit=100')
         @request_api = Net::HTTP.get(uri)
         @most_active = JSON.parse(@request_api)
        
    end       


    private

    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: ENV['SAND_BOX_KEY'],
            endpoint: 'https://cloud.iexapis.com/v1/'
          )
    end

    def stock_params
        params.require(:stock).permit(:symbol)
    end

end
