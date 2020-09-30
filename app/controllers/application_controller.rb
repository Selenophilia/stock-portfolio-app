class ApplicationController < ActionController::Base
    before_action :authenticate_user!


    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from IEX::Errors::SymbolNotFoundError, with: :no_symbol_error

    rescue_from Faraday::ConnectionFailed, with: :no_connection_error

    private
    def no_symbol_error
         flash[:notice] = "Please enter a symbol"  
         redirect_to user_stock_index_path(current_user.id)
    end 

    def no_connection_error
        flash[:notice] = "No Internet connection"  
        redirect_to user_stock_index_path(current_user.id)
    end 

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
    end

end
