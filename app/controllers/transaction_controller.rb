class TransactionController < ApplicationController
    before_action :load_api
    def index
    end 
    
    def create
    byebug
    @user = current_user


    end 

    private
    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: 'Tpk_21780fe8aa454bbe84a3a7d693b51372',
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
    end

    def transaction_params
        params.require(:transaction).permit(:user_id, :quantity, :stock_id,
        stock_attributes: [:symbol])
    end

end
