require_relative '../config/environment'

puts "Welcome to the Franchise Infomatic!"

ActiveRecord::Base.logger = nil

cli = CLI.new

company = cli.get_company

cli.change_franchise_owner(company)

cli.franchise_with_highest_profit

#cli.delete_franchise(company)