class CLI  
  # this method gets company name and finds it in database
  def get_company
    puts "Please enter your company name:"
    company_name = gets.strip

    company = Company.find_by(name: company_name)
    company
  end

  # this method creates a new company
  def create_new_company
    puts "Please provide a username and password."
    puts "Username:"
    username = gets.strip

    puts "Password:"
    password = gets.strip

    company = Company.create({ :name => company_name, :password => password, :username => username })
  end
  # this method checks if the username and password provided are correct
  def username_and_password_check
    company = get_company
    if get_username_and_test_validity(company)
      if get_password_and_test_validity(company)
      else 
        puts "That is not the correct password, please try again."
        return
      end
    else 
      puts "That is not the correct username, please try again."
      return
    end
    company
  end

  # next two return true or false based on input
  def get_username_and_test_validity(company)
    prompt = TTY::Prompt.new
    username = prompt.ask("Please enter your username:")
    company.username == username
  end

  def get_password_and_test_validity(company)
    prompt = TTY::Prompt.new
    password = prompt.mask("Please enter your password:")
    company.password == password
  end

  # this method finds and displays the franchises owned by the user-company
  def display_franchises(company)
    puts "#{company.name} owns these franchises:"
    company.franchises.select { |franchise| puts "Franchise #{franchise.id} in #{franchise.location}" }
  end

  # this method returns true if the company owns the provided franchise
  def valid_franchise_choice(company, id)
    company.franchises.exists?(id)
  end

  # this method changes the owner of an existing franchise that belongs to the user-company
  def change_franchise_owner
    company = get_company
    display_franchises(company)
    puts "Please enter the id number for the franchise whose ownership has changed."
    id = gets.strip
    # is this a valid choice?
    if valid_franchise_choice(company, id) 
      puts "Please enter the name of the new owner."
      new_owner = gets.strip
      if !Owner.exists?(name: new_owner)
        Owner.create(name: new_owner)
      end

      franchise = Franchise.where(id: id).update(owner_id: Owner.find_by(name: new_owner).id)
      franchise.select { |franchise| puts "Franchise #{franchise.id} has new owner #{franchise.owner.name}." }
    else
      puts "Please select an id from the list above next time or find an owner to purchase a franchise!" 
      return 
    end
  end

  # this method closes an franchise that belongs to the user-company
  def delete_franchise
    company = get_company
    display_franchises(company)
    puts "Please enter the id number for the franchise you would like to close."
    id = gets.strip
    # valid choice?
    valid_franchise_choice(company, id)

    Franchise.find(id).destroy
    puts "Franchise #{id} has been closed."
  end

  # this method shows the highest-earning franchise owned by the user-company
  def franchise_with_highest_profit
    company = get_company
    big_earner = company.franchises.max_by { |franchise| franchise.profit }
    puts "Franchise #{big_earner.id} has the highest profit, having earned $#{big_earner.profit}."
  end

  #create a new franchise
  def create_franchise
    company = get_company

    puts "Please enter Owner name:"
    owner_name = gets.chomp
    owner = Owner.find_by name: owner_name
    if owner == nil
      owner = Owner.create({ :name => owner_name })
    end
    #ask for location
    puts "What is the location?"
    location = gets.chomp

    Franchise.create({ 
      :profit => 0, 
      :location => location, 
      :owner_id => owner.id,
      :company_id => company.id
    })

    puts "Complete!"
  end

  def owner_and_franchises
    puts "Please enter owner name to see franchises:"
    owner_name = gets.chomp
    owner = Owner.find_by name: owner_name
    franchise = Franchise.find_by owner_id: owner.id
    company = Company.find_by id: franchise.company_id
  
    puts "This owner owns franchise #{franchise.id} in #{franchise.location},
    with parent company #{company.name}."
  end

  #enter location to see profit
  def location
    puts "Please enter location to see profit:"
    franchise_location = gets.chomp
    franchise = Franchise.find_by location: franchise_location
    puts "This location's profit is $#{franchise.profit}."
  end

  def search(prompt)
    lookup_options = [
      {"By Owner"=> -> do owner_and_franchises end},
      {"By Location"=> -> do location end }, 
      {"Franchise with highest profit"=> -> do franchise_with_highest_profit end}, 
      {"Exit" => -> do exit end}
    ]
    prompt.select('What would you like to search for?', lookup_options)
  end
  
  def menu
    prompt = TTY::Prompt.new
    menu_options = [
      {"Create Franchise"=> -> do create_franchise end},
      {"Delete Franchise"=> -> do delete_franchise end }, 
      {"Change Owner of Franchise"=> -> do change_franchise_owner end}, 
      {"Search"=> -> do search(prompt) end},
      {"Exit" => -> do exit end}
    ]
    prompt.select('What do you want to do?', menu_options)
  end

  def run
    puts "Welcome to the Franchise Infomatic!"

    # company = get_company

    # menu
  end
end


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