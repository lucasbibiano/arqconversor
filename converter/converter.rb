class Converter
  
  def initialize(from, value)
    @from = from
    @value = BigDecimal.new(value)
     
    ExchangeServiceConnector.new.get_webservice_data
  end
  
  def convert   
    currency_to = Currency.find_by(name: @from)
    result = {}
    
    Currency.all.each do |currency_from|
      to_in_eu = @value / currency_to.value
      result[currency_from.name] = (to_in_eu * currency_from.value).round(2)
    end
    
    return result
  end
  
  
end