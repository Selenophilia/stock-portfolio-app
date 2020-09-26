IEX::Api.configure do |config|
    config.publishable_token = 'pk_fe8b0fd4b3e748be8a5d740e449fc4f7' # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
    config.secret_token = 'secret_token' # defaults to ENV['IEX_API_SECRET_TOKEN']
    config.endpoint =  'https://sandbox.iexapis.com/v1'
    #config.endpoint = 'https://cloud.iexapis.com/v1' 
end