class Converter
  
  def initialize(from, to, value)
    @from = from
    @to = to
    @value = BigDecimal.new(value)
     
    ExchangeServiceConnector.new.get_webservice_data
  end
  
  def convert
    currency_from = Currency.find_by(name: @from)
    currency_to = Currency.find_by(name: @to)
    
    from_in_eu = @value / currency_from.value
    
    return from_in_eu * currency_to.value
  end
  
  
end