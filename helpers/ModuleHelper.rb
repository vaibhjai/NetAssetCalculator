module Helper
  HOLDING_URI = 'https://raw.githubusercontent.com/arcjsonapi/HoldingValueCalculator/master/paging/holding_start'.freeze
  PRICE_URI = 'https://raw.githubusercontent.com/arcjsonapi/HoldingValueCalculator/master/paging/pricing_start'.freeze

  def validate_input_date(date)
    if date.nil? || date.length<8 || date.length>8 || !valid_date?(date[0..3], date[4..5], date[6..7])
      raise Exception.new('Invalid Date')
    end
  end

  def valid_date?(year, month, date)
    case month
    when '01'
      return false if date>'31' || date<'01'
    when '02'
      if (year.to_i) % 4 == 0
        return false if date>'29' || date<'01'
      else
        return false if date>'28' || date<'01'
      end
    when '03'
      return false if date>'31' || date<'01'
    when '04'
      return false if date>'30' || date<'01'
    when '05'
      return false if date>'31' || date<'01'
    when '06'
      return false if date>'30' || date<'01'
    when '07'
      return false if date>'31' || date<'01'
    when '08'
      return false if date>'31' || date<'01'
    when '09'
      return false if date>'30' || date<'01'
    when '10'
      return false if date>'31' || date<'01'
    when '11'
      return false if date>'30' || date<'01'
    when '12'
      return false if date>'31' || date<'01'
    else
      return false
    end
    return true
  end

  def read_holdings(hash, input_date)
    next_page = HOLDING_URI
    while true
      uri = URI(next_page)
      response = Net::HTTP.get_response(uri)
      raise Exception.new("Unexpected response from holdings server") if response.code != '200'

      response = JSON.parse(response.body)
      response['data'].each do |data|
        date = data['date']
        break if date>input_date
        if date == input_date
          security = data['security']
          quantity = data['quantity']
          hash["#{date}_#{security}"] = quantity
        end
      end
      next_page = response['nextPage']
      break if next_page.nil? || response['data'].last['date']>input_date
    end
    return hash
  end

  def read_prices(hash, input_date)
    next_page = PRICE_URI
    while true
      uri = URI(next_page)
      response = Net::HTTP.get_response(uri)
      raise Exception.new("Unexpected response from prices server") if response.code != '200'

      response = JSON.parse(response.body)
      response['data'].each do |data|
        date = data['date']
        if date == input_date
          security = data['security']
          price = data['price'].to_f
          hash["#{date}_#{security}"] = price
        end
      end
      next_page = response['nextPage']
      break if next_page.nil? || response['data'].last['date']>input_date
    end
    return hash
  end

  def calculate_net_worth(holdings, prices)
    total = 0
    holdings.each do |k, v|
      total += v*prices[k]
    end
    return total
  end
end
