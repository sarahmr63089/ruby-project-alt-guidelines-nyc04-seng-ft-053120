# require 'tty-prompt'
# require 'active_record'
# require_relative '../config/environment'

# class CLI
#   # this method gets or creates the user-company
#   def get_company
#     puts "Please enter your company name:"
#     company_name = gets.strip
#     # if company doesn't exist create new company -- snag from Jacie's create method
#     company = Company.find_by(name: company_name)
#   end
  
#   # this method finds and displays the franchises owned by the user-company
#   def display_franchises(company)
#     puts "#{company.name} owns these franchises:"
#     company.franchises.select { |franchise| puts "Franchise #{franchise.id} in #{franchise.location}" }
#   end

#   # this method checks if the user-company owns the franchise with the given id
#   def valid_franchise_choice(company, id)
#     # to be a valid choice, the franchise must be one owned by the company
#     if !company.franchises.exists?(id)
#       puts "Please select an id from the list above next time or find an owner to purchase a franchise!" 
#     end
#   end
  
#   # this method changes the owner of an existing franchise that belongs to the user-company
#   def change_franchise_owner(company)
#     display_franchises(company)
#     puts "Please enter the id number for the franchise whose ownership has changed."
#     id = gets.strip
#     # is this a valid choice? -- method needs finishing
#     if !valid_franchise_choice(company, id)
#       return 
#     else 
#       puts "Please enter the name of the new owner."
#       new_owner = gets.strip
#       if !Owner.exists?(name: new_owner)
#         Owner.create(name: new_owner)
#       end

#       franchise = Franchise.where(id: id).update(owner_id: Owner.find_by(name: new_owner).id)
#       franchise.select { |franchise| puts "Franchise #{franchise.id} has new owner #{franchise.owner.name}." }
#     end
#   end

#   # this method closes an franchise that belongs to the user-company
#   def delete_franchise(company)
#     display_franchises(company)
#     puts "Please enter the id number for the franchise you would like to close."
#     id = gets.strip
#     # valid choice?
#     valid_franchise_choice(company, id)

#     Franchise.find(id).destroy
#     puts "Franchise #{id} has been closed."
#   end
  
#   # this method shows the highest-earning franchise
#   def franchise_with_highest_profit
#     big_earner = Franchise.all.max_by { |franchise| franchise.profit }
#     puts "Franchise #{big_earner.id} has the highest profit, having earned #{big_earner.profit}. It is owned by #{big_earner.owner.name} with parent company #{big_earner.company.name}."
#   end
# end
# #create a new franchise
# def create_franchise
#   puts "Please enter Company name:"
#   company_name = gets.chomp
#   company = Company.find_by name: company_name
#   if company == nil
#       company = Company.create({ :name => company_name })
#   end

#   puts "Please enter Owner name:"
#   owner_name = gets.chomp
#   owner = Owner.find_by name: owner_name
#   if owner == nil
#       owner = Owner.create({ :name => owner_name })
#   end
# #ask for location
#   puts "What is the location?"
#   location = gets.chomp

#   Franchise.create({ 
#       :profit => 0, 
#       :location => location, 
#       :owner_id => owner.id,
#       :company_id => company.id
#   })

#   puts "Complete!"
# end


# def owner_and_franchises
#   puts "Please enter owner name to see franchises:"
#   owner_name = gets.chomp
#   owner = Owner.find_by name: owner_name
#   franchise = Franchise.find_by owner_id: owner.id
#   company = Company.find_by id: franchise.company_id
  
#   puts "This owner owns franchise #{franchise.id} in #{franchise.location},
#    with parent company #{company.name}."
# end

# #enter location to see profit
# def location
#   puts "Please enter location to see profit:"
#   franchise_location = gets.chomp
#   franchise = Franchise.find_by location: franchise_location
#   puts "This location's profit is #{franchise.profit}"
# end


# puts "Welcome to the Franchise Infomatic!"

# ActiveRecord::Base.logger = nil

# cli = CLI.new

# #company = cli.get_company

# #cli.change_franchise_owner(company)


# def menu
#   prompt = TTY::Prompt.new
#   menu_options = [
#     {"Create Franchise"=> -> do create_franchise end},
#     # {"Delete Franchise"}, 
#     # {"Change Owner of Franchise"}, 
#     # {"Search"},
#     # {"Exit" =}
#   ]
#   #main_menu= %w(Create Franchise,Delete Franchise,Change Owner of Franchise,Lookup)
#   prompt.select('What do you want to do?', menu_options)
#   #if statement if they choose lookup to then ask what they want
#   #to look up.
#     # if prompt.select == lookup  
#     # lookup = 
#     # prompt.multi_select("What would you like to Lookup", choices)
#     # lookup_options = ["By Owner", "By Location,","Franchise with highest profit"]
#     # prompt.select('What would you like to search for?', lookup_option)
#   end

#   menu 
