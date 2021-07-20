require 'json'
require 'net/http'
require_relative 'helpers/ModuleHelper'
include Helper

input_date = ARGV[0]
Helper.validate_input_date(input_date)

holdings_hash = {}
prices_hash = {}
holdings_hash = Helper.read_holdings(holdings_hash, input_date)
prices_hash = Helper.read_prices(prices_hash, input_date)
net_worth = Helper.calculate_net_worth(holdings_hash, prices_hash)
puts "Net Asset Value: #{net_worth.round(3)}"
