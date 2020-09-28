class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :quantity, numericality: {only_integer: true}

  accepts_nested_attributes_for :stock

  def stock_attributes(stock)
    client = IEX::Api::Client.new(
      publishable_token: 'Tpk_21780fe8aa454bbe84a3a7d693b51372',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    self.stock            = Stock.find_or_create_by(symbol: stock[:symbol])
    self.stock.price      = client.price(stock[:symbol]) #client.price('MSFT') should get price per symbol
    self.stock.open_price = client.quote(stock[:symbol]).previous_close
    self.stock.update(stock)
  end 

end
