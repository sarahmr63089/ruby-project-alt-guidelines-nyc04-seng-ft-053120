require_relative '../config/environment'
ActiveRecord::Base.logger = nil

cli = CLI.new

cli.run

