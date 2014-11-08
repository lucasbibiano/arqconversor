class Converter
  
  def initialize(from, value)
    @from = from
    @value = BigDecimal.new(value)
     
    ExchangeServiceConnector.new.get_webservice_data
  end
  
  def convert
    currency_from = Currency.find_by(name: @from)
    result = {}
    
    Currency.all.each do |currency_to|
      from_in_eu = @value / currency_from.value
      result[currency_to.name] = (from_in_eu * currency_to.value).round(2)
    end
    
    return result
  end
  
  
end