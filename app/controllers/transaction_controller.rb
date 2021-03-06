class TransactionController < ApplicationController
    before_action :load_api
    before_action :transaction_params, only: [:create]
    def index
        @user = current_user
        @transactions = Transaction.where(user_id:  @user.id)

    end 
    
    def create
        @user = current_user
        stock_price = @client.quote(params[:transaction][:stock_attributes][:symbol]).latest_price
        total_price = stock_price * params[:transaction][:quantity].to_i

        if current_user.balance > total_price
            @transaction = Transaction.create(transaction_params)
            if @transaction.valid?
                     @transaction.purchase_price = total_price
                     @transaction.purchase_date = DateTime.now
                     @transaction.save
                     @user.calc_total_balance(total_price)
                     redirect_to user_stock_index_path(current_user.id)
            else    
                flash[:error] = "Please enter a whole number of shares to purchase."
                redirect_to user_stock_index_path(current_user.id)
            end 
        else
            flash[:error] = "Insuficient balance!"
            redirect_to user_stock_index_path(current_user.id)
        end 
    end 

    private
    def load_api
        @client = IEX::Api::Client.new(
            publishable_token: ENV["SAND_BOX_KEY"],
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
    end

    def transaction_params
        #byebug  
        params.require(:transaction).permit(:user_id, :quantity, :stock_id,
        :stock_attributes => [:symbol])
    end

end
