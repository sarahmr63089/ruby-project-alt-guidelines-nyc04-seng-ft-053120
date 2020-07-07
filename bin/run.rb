require_relative '../config/environment'

puts "Welcome to the Franchise Infomatic!"

ActiveRecord::Base.logger = nil

cli = CLI.new