require 'open-uri'

class ExchangeServiceConnector
  def get_webservice_data
    if Info.first.nil? || (Time.now - Info.first.last_updated > 1.day)
      load_data
    end
  end
  
  private
  def load_data
    xml_text = open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml") { |io| io.read }
    
    data = xml_text.scan(/'\S*'/)
    
    last_updated = Date.parse(data[0])
    
    Currency.destroy_all
    
    data[1..-1].each_slice(2) do |c, v|
      Currency.create(name: c[1..-2], value: v[1..-2])
    end
    
    Currency.create(name: "EUR", value: 1)
    
    i = Info.first || Info.new
    i.last_updated = last_updated
    i.save
  end
end