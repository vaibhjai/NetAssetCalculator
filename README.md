## Net Asset Value Calculator

A portfolio management firm invests money on behalf of the investors to generate profits. The firm buys securities/contracts (in layman terms shares/stocks) from the market and sells them to realize the profits/losses. The Net Asset Value (NAV) is the net value of all the securities held by the firm on a given day. Let's say the firm holds the below securities:

Holdings on 01/01/2019
Security        Quantity        Portfolio
IBM     100     GROWTH
GOOGLE  200     GROWTH
IBM     200     BALANCES

Market Price on 01/01/2019
Security        Market Price
IBM     15.25
GOOGLE  25.67

Then the NAV is calculated as the sum of value of all securities held by the firm on that day. So the value of holding as of 01/01/2019 is:

Holding Value = (100 * $15.25) + (200 * $25.67) + (200 * $15.25) = $9709

## REST APIs for Holding Service
Holding Service - vends details of the security holding for each day
api end-point: https://raw.githubusercontent.com/arcjsonapi/HoldingValueCalculator/master/api/holding
api end-point with paging: https://raw.githubusercontent.com/arcjsonapi/HoldingValueCalculator/master/paging/holding_start

## REST APIs for Pricing Service
Pricing Service - vends out the price for securities for each of the traded day
api end-point: https://raw.githubusercontent.com/arcjsonapi/HoldingValueCalculator/master/api/pricing
api end-point with paging: https://raw.githubusercontent.com/arcjsonapi/HoldingValueCalculator/master/paging/pricing_start

## Assumptions
1. Date will be given as input.
2. Throwing error in case of invalid input date

## Pre-requisites to run code:
Ruby should be pre-installed (Using 2.6.6 ruby version).

## Steps to run code:
1. Go to the root folder and run command `bundle install` to install the gems locally.
2. Run command `ruby app.rb <input_date>` to test the calculator

## Sample Inputs and Outputs

1.  Input - `ruby app.rb 20190101`
    Output - `Net Asset Value: 812010.36`

2.  Input - `ruby app.rb 20191231`
    Output - `Net Asset Value: 609789.82`

3.  Input - `ruby app.rb 20191331`
    Output - `Invalid Date (Exception)`

4.  Input - `ruby app.rb 20190132`
    Output - `Invalid Date (Exception)`
